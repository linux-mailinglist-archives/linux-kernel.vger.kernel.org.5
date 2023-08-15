Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCF77CDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjHOOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjHOOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:08:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5E199A;
        Tue, 15 Aug 2023 07:08:36 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQCkn2Qd3zrSQJ;
        Tue, 15 Aug 2023 22:07:13 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 22:08:32 +0800
Content-Type: multipart/mixed;
        boundary="------------PE66p7OpYyuyMLwQPckgQUX1"
Message-ID: <2fa67edb-7cf2-e6bb-a2ab-425911226fbb@huawei.com>
Date:   Tue, 15 Aug 2023 22:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/13] scsi: Support LUN/target based error handle
Content-Language: en-US
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>
References: <20230723234422.1629194-1-haowenchao2@huawei.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230723234422.1629194-1-haowenchao2@huawei.com>
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------PE66p7OpYyuyMLwQPckgQUX1
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/24 7:44, Wenchao Hao wrote:
> The origin error handle would set host to recovery state and perform
> error recovery operations, and makes all LUNs which share a same host
> can not handle IOs. This phenomenon is unbearable for systems which
> deploy many LUNs in one HBA.
> 
> This patchset introduce support for LUN/target based error handle,
> drivers can chose if to implement it. They can implement LUN, target or
> both of LUN and target based error handle by their own error handle
> strategy. The first patch defined this framework, it abstract three
> key operations which are: add error command, wake up error handle, block
> ios when error command is added and recoverying. Drivers should
> implement these three function callbacks and setup to SCSI middle level.
> 
> Besides the basic framework, this patchset also add a basic LUN/target
> based error handle strategy.
> 
> For LUN based eh, it would try check sense, start unit and reset LUN,
> if all above steps can not recovery all error commands, fallback to
> further recovery like tartget based (if implemented) or host based error
> handle.
> 
> It's same for tartget based eh, it would try check sense, start unit,
> reset LUN and reset target. If all above steps can not recovery all error
> commands, fallback to further recovery which is host based error handle.
> 
> This patchset is tested by scsi_debug which support single LUN error
> injection, the scsi_debug patches is here:
> 
> https://lore.kernel.org/linux-scsi/20230723234105.1628982-1-haowenchao2@huawei.com/T/#t
> 

I tested this patch set with scsi_debug with following scenarios, check
attachments to get my test script and result logs.

+-----------+---------+-------------------------------------------------------+
| lun reset | TUR     | Desired result                                        |
+ --------- + ------- + ------------------------------------------------------+
| success   | success | retry or finish with  EIO(may offline disk)           |
+ --------- + ------- + ------------------------------------------------------+
| success   | fail    | fallback to host  recovery, retry or finish with      |
|           |         | EIO(may offline disk)                                 |
+ --------- + ------- + ------------------------------------------------------+
| fail      | NA      | fallback to host  recovery, retry or finish with      |
|           |         | EIO(may offline disk)                                 |
+ --------- + ------- + ------------------------------------------------------+

+-----------+---------+--------------+---------+------------------------------+
| lun reset | TUR     | target reset | TUR     | Desired result               |
+-----------+---------+--------------+---------+------------------------------+
| success   | success | NA           | NA      | retry or finish with         |
|           |         |              |         | EIO(may offline disk)        |
+-----------+---------+--------------+---------+------------------------------+
| success   | fail    | success      | success | retry or finish with         |
|           |         |              |         | EIO(may offline disk)        |
+-----------+---------+--------------+---------+------------------------------+
| fail      | NA      | success      | success | retry or finish with         |
|           |         |              |         | EIO(may offline disk)        |
+-----------+---------+--------------+---------+------------------------------+
| fail      | NA      | success      | fail    | fallback to host recovery,   |
|           |         |              |         | retry or finish with EIO(may |
|           |         |              |         | offline disk)                |
+-----------+---------+--------------+---------+------------------------------+
| fail      | NA      | fail         | NA      | fallback to host  recovery,  |
|           |         |              |         | retry or finish with EIO(may |
|           |         |              |         | offline disk)                |
+-----------+---------+--------------+---------+------------------------------+

+-----------+---------+--------------+---------+------------------------------+
| lun reset | TUR     | target reset | TUR     | Desired result               |
+-----------+---------+--------------+---------+------------------------------+
| success   | success | NA           | NA      | retry or finish with         |
|           |         |              |         | EIO(may offline disk)        |
+-----------+---------+--------------+---------+------------------------------+
| success   | fail    | success      | success | lun recovery fallback to     |
|           |         |              |         | target recovery, retry or    |
|           |         |              |         | finish with EIO(may offline  |
|           |         |              |         | disk                         |
+-----------+---------+--------------+---------+------------------------------+
| fail      | NA      | success      | success | lun recovery fallback to     |
|           |         |              |         | target recovery, retry or    |
|           |         |              |         | finish with EIO(may offline  |
|           |         |              |         | disk                         |
+-----------+---------+--------------+---------+------------------------------+
| fail      | NA      | success      | fail    | lun recovery fallback to     |
|           |         |              |         | target recovery, then fall   |
|           |         |              |         | back to host recovery, retry |
|           |         |              |         | or fhinsi with EIO(may       |
|           |         |              |         | offline disk)                |
+-----------+---------+--------------+---------+------------------------------+
| fail      | NA      | fail         | NA      | lun recovery fallback to     |
|           |         |              |         | target recovery, then fall   |
|           |         |              |         | back to host recovery, retry |
|           |         |              |         | or fhinsi with EIO(may       |
|           |         |              |         | offline disk)                |
+-----------+---------+--------------+---------+------------------------------+


> Wenchao Hao (13):
>    scsi: Define basic framework for driver LUN/target based error handle
>    scsi:scsi_error: Move complete variable eh_action from shost to sdevice
>    scsi:scsi_error: Check if to do reset in scsi_try_xxx_reset
>    scsi:scsi_error: Add helper scsi_eh_sdev_stu to do START_UNIT
>    scsi:scsi_error: Add helper scsi_eh_sdev_reset to do lun reset
>    scsi:scsi_error: Add flags to mark error handle steps has done
>    scsi:scsi_error: Define helper to perform LUN based error handle
>    scsi:scsi_error: Add LUN based error handler based previous helper
>    scsi:core: increase/decrease target_busy without check can_queue
>    scsi:scsi_error: Define helper to perform target based error handle
>    scsi:scsi_error: Add target based error handler based previous helper
>    scsi:scsi_debug: Add param to control if setup LUN based error handle
>    scsi:scsi_debug: Add param to control if setup target based error handle
> 
>   drivers/scsi/scsi_debug.c  |  19 +
>   drivers/scsi/scsi_error.c  | 705 ++++++++++++++++++++++++++++++++++---
>   drivers/scsi/scsi_lib.c    |  23 +-
>   drivers/scsi/scsi_priv.h   |  20 ++
>   include/scsi/scsi_device.h |  97 +++++
>   include/scsi/scsi_eh.h     |   4 +
>   include/scsi/scsi_host.h   |   2 -
>   7 files changed, 813 insertions(+), 57 deletions(-)
> 

--------------PE66p7OpYyuyMLwQPckgQUX1
Content-Type: application/x-gzip; name="logs.tar.gz"
Content-Disposition: attachment; filename="logs.tar.gz"
Content-Transfer-Encoding: base64

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
y/dY/hfMj0h8ALgBAA==
--------------PE66p7OpYyuyMLwQPckgQUX1
Content-Type: text/plain; charset="UTF-8"; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpzY3NpX2RlYnVnPS9tbnQvbWFpbmxpbmUvZHJpdmVycy9zY3NpL3Njc2lf
ZGVidWcua28gCgpmdW5jdGlvbiBjbGVhcl9lcnJvcigpCnsKCWVycm9yPSQxCgl0bXBmaWxl
PSQkX2NsZWFyCgljYXQgJGVycm9yIHwgZ3JlcCAtdiBUeXBlIHwgYXdrICd7cHJpbnQgJDEs
JDN9JyA+ICR0bXBmaWxlIAoJd2hpbGUgcmVhZCAtciBsaW5lOyBkbyBlY2hvICItICRsaW5l
IiA+ICRlcnJvcjsgZG9uZSA8ICR0bXBmaWxlCglybSAtcmYgJHRtcGZpbGUKCgllY2hvIDAg
PiAvc3lzL2tlcm5lbC9kZWJ1Zy9zY3NpX2RlYnVnL3RhcmdldCR0YXJnZXRfaWQvZmFpbF9y
ZXNldAp9CgpmdW5jdGlvbiBsdW5fdGVzdF9zZW5zZTEoKQp7CgllY2hvICJMVU4gcmVzZXQg
c3VjY2VzcywgVFVSIHN1Y2Nlc3MiCgoJIyBpbmplY3QgdGltZW91dCBjb21tYW5kIGZvciB3
cml0ZSBjb21tYW5kCgllY2hvICIwIC0xMCAweDJhICIgPiAke2Vycm9yfQoJIyBpbmplY3Qg
YWJvcnQgY29tbWFuZCBmb3Igd3JpdGUgY29tbWFuZAoJZWNobyAiMyAtMSAweDJhICIgPiAk
e2Vycm9yfQoKCWRkIGlmPS9kZXYvemVybyBvZj0vZGV2LyRkaXNrIGJzPTFLIGNvdW50PTEw
IG9mbGFnPWRpcmVjdAoJZWNobyAkKGNhdCAvc3lzL2Jsb2NrLyRkaXNrL2RldmljZS9zdGF0
ZSkKCgljbGVhcl9lcnJvciAkZXJyb3IKCWVjaG8gcnVubmluZyA+IC9zeXMvYmxvY2svJGRp
c2svZGV2aWNlL3N0YXRlCn0KCmZ1bmN0aW9uIGx1bl90ZXN0X3NlbnNlMigpCnsKCWVjaG8g
IkxVTiByZXNldCBzdWNjZXNzLCBUVVIgZmFpbGVkIgoKCSMgaW5qZWN0IHRpbWVvdXQgY29t
bWFuZCBmb3Igd3JpdGUgY29tbWFuZAoJZWNobyAiMCAtMTAgMHgyYSAiID4gJHtlcnJvcn0K
CSMgaW5qZWN0IGFib3J0IGNvbW1hbmQgZm9yIHdyaXRlIGNvbW1hbmQKCWVjaG8gIjMgLTEg
MHgyYSAiID4gJHtlcnJvcn0KCSMgaW5qZWN0IHRpbWVvdXQgY29tbWFuZCBmb3IgVFVSIGNv
bW1hbmQKCWVjaG8gIjAgLTEgMHgwICIgPiAke2Vycm9yfQoKCWRkIGlmPS9kZXYvemVybyBv
Zj0vZGV2LyRkaXNrIGJzPTFLIGNvdW50PTEwIG9mbGFnPWRpcmVjdAoJZWNobyAkKGNhdCAv
c3lzL2Jsb2NrLyRkaXNrL2RldmljZS9zdGF0ZSkKCgljbGVhcl9lcnJvciAkZXJyb3IKCWVj
aG8gcnVubmluZyA+IC9zeXMvYmxvY2svJGRpc2svZGV2aWNlL3N0YXRlCn0KCmZ1bmN0aW9u
IGx1bl90ZXN0X3NlbnNlMygpCnsKCWVjaG8gIkxVTiByZXNldCBmYWlsZWQsIGZhbGxiYWNr
IHRvIHRhcmdldCByZXNldCBzdWNjZXNzIgoKCSMgaW5qZWN0IHRpbWVvdXQgY29tbWFuZCBm
b3Igd3JpdGUgY29tbWFuZAoJZWNobyAiMCAtMTAgMHgyYSAiID4gJHtlcnJvcn0KCSMgaW5q
ZWN0IGFib3J0IGNvbW1hbmQgZm9yIHdyaXRlIGNvbW1hbmQKCWVjaG8gIjMgLTEgMHgyYSAi
ID4gJHtlcnJvcn0KCSMgaW5qZWN0IGx1bnJlc2V0IGZhaWxlZCAKCWVjaG8gIjQgLTEgMHhm
ZiIgPiAke2Vycm9yfQoKCWRkIGlmPS9kZXYvemVybyBvZj0vZGV2LyRkaXNrIGJzPTFLIGNv
dW50PTEwIG9mbGFnPWRpcmVjdAoJZWNobyAkKGNhdCAvc3lzL2Jsb2NrLyRkaXNrL2Rldmlj
ZS9zdGF0ZSkKCgljbGVhcl9lcnJvciAkZXJyb3IKCWVjaG8gcnVubmluZyA+IC9zeXMvYmxv
Y2svJGRpc2svZGV2aWNlL3N0YXRlCn0KCmZ1bmN0aW9uIHRhcmdldF90ZXN0X3NlbnNlMSgp
CnsKCWVjaG8gIkxVTiByZXNldCBzdWNjZXNzLCBUVVIgc3VjY2VzcyIKCgkjIGluamVjdCB0
aW1lb3V0IGNvbW1hbmQgZm9yIHdyaXRlIGNvbW1hbmQKCWVjaG8gIjAgLTEwIDB4MmEgIiA+
ICR7ZXJyb3J9CgkjIGluamVjdCBhYm9ydCBjb21tYW5kIGZvciB3cml0ZSBjb21tYW5kCgll
Y2hvICIzIC0xIDB4MmEgIiA+ICR7ZXJyb3J9CgoJZGQgaWY9L2Rldi96ZXJvIG9mPS9kZXYv
JGRpc2sgYnM9MUsgY291bnQ9MTAgb2ZsYWc9ZGlyZWN0CgllY2hvICQoY2F0IC9zeXMvYmxv
Y2svJGRpc2svZGV2aWNlL3N0YXRlKQoKCWNsZWFyX2Vycm9yICRlcnJvcgoJZWNobyBydW5u
aW5nID4gL3N5cy9ibG9jay8kZGlzay9kZXZpY2Uvc3RhdGUKfQoKZnVuY3Rpb24gdGFyZ2V0
X3Rlc3Rfc2Vuc2UyKCkKewoJZWNobyAiTFVOIHJlc2V0IHN1Y2Nlc3MsIFRVUiBmYWlsZWQs
IHRhcmdldCByZXNldCBzdWNjZXNzLCBUVVIgc3VjY2VzcyIKCgkjIGluamVjdCB0aW1lb3V0
IGNvbW1hbmQgZm9yIHdyaXRlIGNvbW1hbmQKCWVjaG8gIjAgLTEwIDB4MmEgIiA+ICR7ZXJy
b3J9CgkjIGluamVjdCBhYm9ydCBjb21tYW5kIGZvciB3cml0ZSBjb21tYW5kCgllY2hvICIz
IC0xIDB4MmEgIiA+ICR7ZXJyb3J9CgkjIGluamVjdCB0aW1lb3V0IGNvbW1hbmQgZm9yIFRV
UiBjb21tYW5kCgllY2hvICIwIC0xIDB4MCAiID4gJHtlcnJvcn0KCglkZCBpZj0vZGV2L3pl
cm8gb2Y9L2Rldi8kZGlzayBicz0xSyBjb3VudD0xMCBvZmxhZz1kaXJlY3QKCWVjaG8gJChj
YXQgL3N5cy9ibG9jay8kZGlzay9kZXZpY2Uvc3RhdGUpCgoJY2xlYXJfZXJyb3IgJGVycm9y
CgllY2hvIHJ1bm5pbmcgPiAvc3lzL2Jsb2NrLyRkaXNrL2RldmljZS9zdGF0ZQp9CgpmdW5j
dGlvbiB0YXJnZXRfdGVzdF9zZW5zZTMoKQp7CgllY2hvICJMVU4gcmVzZXQgZmFpbGVkLCB0
YXJnZXQgcmVzZXQgc3VjY2VzcywgVFVSIHN1Y2Nlc3MiCgoJIyBpbmplY3QgdGltZW91dCBj
b21tYW5kIGZvciB3cml0ZSBjb21tYW5kCgllY2hvICIwIC0xMCAweDJhICIgPiAke2Vycm9y
fQoJIyBpbmplY3QgYWJvcnQgY29tbWFuZCBmb3Igd3JpdGUgY29tbWFuZAoJZWNobyAiMyAt
MSAweDJhICIgPiAke2Vycm9yfQoJIyBpbmplY3QgbHVucmVzZXQgZmFpbGVkIAoJZWNobyAi
NCAtMSAweGZmIiA+ICR7ZXJyb3J9CgoJZGQgaWY9L2Rldi96ZXJvIG9mPS9kZXYvJGRpc2sg
YnM9MUsgY291bnQ9MTAgb2ZsYWc9ZGlyZWN0CgllY2hvICQoY2F0IC9zeXMvYmxvY2svJGRp
c2svZGV2aWNlL3N0YXRlKQoKCWNsZWFyX2Vycm9yICRlcnJvcgoJZWNobyBydW5uaW5nID4g
L3N5cy9ibG9jay8kZGlzay9kZXZpY2Uvc3RhdGUKfQoKZnVuY3Rpb24gdGFyZ2V0X3Rlc3Rf
c2Vuc2U0KCkKewoJZWNobyAiTFVOIHJlc2V0IGZhaWxlZCwgdGFyZ2V0IHJlc2V0IHN1Y2Nl
c3MgVFVSIGZhaWxlZCIKCgkjIGluamVjdCB0aW1lb3V0IGNvbW1hbmQgZm9yIHdyaXRlIGNv
bW1hbmQKCWVjaG8gIjAgLTEwIDB4MmEgIiA+ICR7ZXJyb3J9CgkjIGluamVjdCBhYm9ydCBj
b21tYW5kIGZvciB3cml0ZSBjb21tYW5kCgllY2hvICIzIC0xIDB4MmEgIiA+ICR7ZXJyb3J9
CgkjIGluamVjdCBsdW5yZXNldCBmYWlsZWQgCgllY2hvICI0IC0xIDB4ZmYiID4gJHtlcnJv
cn0KCSMgaW5qZWN0IHRpbWVvdXQgY29tbWFuZCBmb3IgVFVSIGNvbW1hbmQKCWVjaG8gIjAg
LTEgMHgwICIgPiAke2Vycm9yfQoKCWRkIGlmPS9kZXYvemVybyBvZj0vZGV2LyRkaXNrIGJz
PTFLIGNvdW50PTEwIG9mbGFnPWRpcmVjdAoJZWNobyAkKGNhdCAvc3lzL2Jsb2NrLyRkaXNr
L2RldmljZS9zdGF0ZSkKCWNsZWFyX2Vycm9yICRlcnJvcgoJZWNobyBydW5uaW5nID4gL3N5
cy9ibG9jay8kZGlzay9kZXZpY2Uvc3RhdGUKfQoKZnVuY3Rpb24gdGFyZ2V0X3Rlc3Rfc2Vu
c2U1KCkKewoJZWNobyAiTFVOIHJlc2V0IGZhaWxlZCwgdGFyZ2V0IHJlc2V0IGZhaWxlZCwg
ZmFsbGJhY2sgdG8gaG9zdCByZWNvdmVyeSIKCgkjIGluamVjdCB0aW1lb3V0IGNvbW1hbmQg
Zm9yIHdyaXRlIGNvbW1hbmQKCWVjaG8gIjAgLTEwIDB4MmEgIiA+ICR7ZXJyb3J9CgkjIGlu
amVjdCBhYm9ydCBjb21tYW5kIGZvciB3cml0ZSBjb21tYW5kCgllY2hvICIzIC0xIDB4MmEg
IiA+ICR7ZXJyb3J9CgkjIGluamVjdCBsdW5yZXNldCBmYWlsZWQgCgllY2hvICI0IC0xIDB4
ZmYiID4gJHtlcnJvcn0KCSMgaW5qZWN0IHRhcmdldCByZXNldCBmYWlsZWQKCWVjaG8gMSA+
IC9zeXMva2VybmVsL2RlYnVnL3Njc2lfZGVidWcvdGFyZ2V0JHRhcmdldF9pZC9mYWlsX3Jl
c2V0CgoJZGQgaWY9L2Rldi96ZXJvIG9mPS9kZXYvJGRpc2sgYnM9MUsgY291bnQ9MTAgb2Zs
YWc9ZGlyZWN0CgllY2hvICQoY2F0IC9zeXMvYmxvY2svJGRpc2svZGV2aWNlL3N0YXRlKQoK
CWNsZWFyX2Vycm9yICRlcnJvcgoJZWNobyBydW5uaW5nID4gL3N5cy9ibG9jay8kZGlzay9k
ZXZpY2Uvc3RhdGUKfQoKc2NzaV9sb2dnaW5nX2xldmVsIC1zIC0tZXJyb3IgNCA+IC9kZXYv
bnVsbCAyPiYxCgppbnNtb2QgJHNjc2lfZGVidWcgbHVuX2VoPVkgdGFyZ2V0X2VoPU4Kc3Ry
PSQobHNzY3NpIHwgZ3JlcCBzY3NpX2RlYnVnIHwgaGVhZCAtbiAxIHwgYXdrICd7cHJpbnQg
JDF9JykKc2NzaV9pZD0ke3N0ciMqXFt9CnNjc2lfaWQ9JHtzY3NpX2lkJVxdKn0KZXJyb3I9
L3N5cy9rZXJuZWwvZGVidWcvc2NzaV9kZWJ1Zy8kc2NzaV9pZC9lcnJvciAKc3RyPSQobHNz
Y3NpIHwgZ3JlcCBzY3NpX2RlYnVnIHwgaGVhZCAtbiAxIHwgYXdrICd7cHJpbnQgJDZ9JykK
ZGlzaz0kKGJhc2VuYW1lICRzdHIpCnRhcmdldF9pZD0ke3Njc2lfaWQlXDoqfQplY2hvIG5v
bmUgPiAvc3lzL2Jsb2NrLyRkaXNrL3F1ZXVlL3NjaGVkdWxlcgplY2hvIDEgICAgPiAvc3lz
L2Jsb2NrLyRkaXNrL2RldmljZS90aW1lb3V0CmVjaG8gMSAgICA+IC9zeXMvYmxvY2svJGRp
c2svZGV2aWNlL2VoX3RpbWVvdXQKCmZvcigobG9vcD0xO2xvb3A8PTM7bG9vcCsrKSkKZG8K
CXRpbWU9JChkYXRlICIrJVktJW0tJWQtJUgtJU0tJVMiKQoJc2luY2U9JChkYXRlICIrJVkt
JW0tJWQgJUg6JU06JVMiKQoJbHVuX3Rlc3Rfc2Vuc2UkbG9vcAoJc2xlZXAgMwoJdW50aWw9
JChkYXRlICIrJVktJW0tJWQgJUg6JU06JVMiKQoJbWtkaXIgbG9ncy9sdW5fc2Vuc2UkbG9v
cAoJam91cm5hbGN0bCAtLXNpbmNlPSIkc2luY2UiIC0tdW50aWw9IiR1bnRpbCIgPiBsb2dz
L2x1bl9zZW5zZSRsb29wLyR0aW1lLmxvZwpkb25lCnJtbW9kIHNjc2lfZGVidWcKCmluc21v
ZCAkc2NzaV9kZWJ1ZyBsdW5fZWg9TiB0YXJnZXRfZWg9WQpzdHI9JChsc3Njc2kgfCBncmVw
IHNjc2lfZGVidWcgfCBoZWFkIC1uIDEgfCBhd2sgJ3twcmludCAkMX0nKQpzY3NpX2lkPSR7
c3RyIypcW30Kc2NzaV9pZD0ke3Njc2lfaWQlXF0qfQplcnJvcj0vc3lzL2tlcm5lbC9kZWJ1
Zy9zY3NpX2RlYnVnLyRzY3NpX2lkL2Vycm9yIApzdHI9JChsc3Njc2kgfCBncmVwIHNjc2lf
ZGVidWcgfCBoZWFkIC1uIDEgfCBhd2sgJ3twcmludCAkNn0nKQpkaXNrPSQoYmFzZW5hbWUg
JHN0cikKZWNobyBub25lID4gL3N5cy9ibG9jay8kZGlzay9xdWV1ZS9zY2hlZHVsZXIKZWNo
byAxICAgID4gL3N5cy9ibG9jay8kZGlzay9kZXZpY2UvdGltZW91dAplY2hvIDEgICAgPiAv
c3lzL2Jsb2NrLyRkaXNrL2RldmljZS9laF90aW1lb3V0CmZvcigobG9vcD0xO2xvb3A8PTU7
bG9vcCsrKSkKZG8KCXRpbWU9JChkYXRlICIrJVktJW0tJWQtJUgtJU0tJVMiKQoJc2luY2U9
JChkYXRlICIrJVktJW0tJWQgJUg6JU06JVMiKQoJdGFyZ2V0X3Rlc3Rfc2Vuc2UkbG9vcAoJ
c2xlZXAgMwoJdW50aWw9JChkYXRlICIrJVktJW0tJWQgJUg6JU06JVMiKQoJbWtkaXIgbG9n
cy90YXJnZXRfc2Vuc2UkbG9vcAoJam91cm5hbGN0bCAtLXNpbmNlPSIkc2luY2UiIC0tdW50
aWw9IiR1bnRpbCIgPiBsb2dzL3RhcmdldF9zZW5zZSRsb29wLyR0aW1lLmxvZwpkb25lCnJt
bW9kIHNjc2lfZGVidWcKCmluc21vZCAkc2NzaV9kZWJ1ZyBsdW5fZWg9WSB0YXJnZXRfZWg9
WQpzdHI9JChsc3Njc2kgfCBncmVwIHNjc2lfZGVidWcgfCBoZWFkIC1uIDEgfCBhd2sgJ3tw
cmludCAkMX0nKQpzY3NpX2lkPSR7c3RyIypcW30Kc2NzaV9pZD0ke3Njc2lfaWQlXF0qfQpl
cnJvcj0vc3lzL2tlcm5lbC9kZWJ1Zy9zY3NpX2RlYnVnLyRzY3NpX2lkL2Vycm9yIApzdHI9
JChsc3Njc2kgfCBncmVwIHNjc2lfZGVidWcgfCBoZWFkIC1uIDEgfCBhd2sgJ3twcmludCAk
Nn0nKQpkaXNrPSQoYmFzZW5hbWUgJHN0cikKZWNobyBub25lID4gL3N5cy9ibG9jay8kZGlz
ay9xdWV1ZS9zY2hlZHVsZXIKZWNobyAxICAgID4gL3N5cy9ibG9jay8kZGlzay9kZXZpY2Uv
dGltZW91dAplY2hvIDEgICAgPiAvc3lzL2Jsb2NrLyRkaXNrL2RldmljZS9laF90aW1lb3V0
CmZvcigobG9vcD0xO2xvb3A8PTU7bG9vcCsrKSkKZG8KCXRpbWU9JChkYXRlICIrJVktJW0t
JWQtJUgtJU0tJVMiKQoJc2luY2U9JChkYXRlICIrJVktJW0tJWQgJUg6JU06JVMiKQoJdGFy
Z2V0X3Rlc3Rfc2Vuc2UkbG9vcAoJc2xlZXAgMwoJdW50aWw9JChkYXRlICIrJVktJW0tJWQg
JUg6JU06JVMiKQoJbWtkaXIgbG9ncy9sdW5fdGFyZ2V0X3NlbnNlJGxvb3AKCWpvdXJuYWxj
dGwgLS1zaW5jZT0iJHNpbmNlIiAtLXVudGlsPSIkdW50aWwiID4gbG9ncy9sdW5fdGFyZ2V0
X3NlbnNlJGxvb3AvJHRpbWUubG9nCmRvbmUKcm1tb2Qgc2NzaV9kZWJ1Zwo=

--------------PE66p7OpYyuyMLwQPckgQUX1--
