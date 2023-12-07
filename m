Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471D9808D46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjLGP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjLGP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:58:03 -0500
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE110EB;
        Thu,  7 Dec 2023 07:58:06 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id E2C36480A13;
        Thu,  7 Dec 2023 10:58:04 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701964684;
 h=content-type : message-id : date : mime-version : subject : to : cc
 : references : from : in-reply-to : from;
 bh=NE5F+XkmWiqyKfytJ561fU875aqUob9lyQJvt8LvMBU=;
 b=luzXdF/HxZgmHb8/UNNpIJzBVngDh2YVFyEYNe7JuiOBlP5uUA9C9K6ED+9H+HVXoF+U/
 sRS9DjKLVRpG94NDQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701964684;
        cv=none; b=JrEVZx033mWBC5xh6tPzhuSoG+yFmxzVqTFJNlRoPBmeFbX57CQAPHVhJKky80ji3BN71/CQJ18dGq8AzSxM12uOtGzvYDgXEdm4Qcw92QcKKLuLIGTlpdaT+8f9lL0kjaEMWO6TvOjGUm24CmCLABYA7C/UIQcolSsXPqKSL9en+j65tZ+GEqhHB8VSgi15eq0FkS1AGt1W2j39XDZQWR5H+of/9UbCfScQLT6vqPYDBYE05RertXZwXad2G2VkmE7oRWxDmGDeLgVfNQWzRqHhkJXS6UHje/qwhLKNncQOhxOhtQjDQauVI8M8P938XrI37k+uxll8LZtWuNKaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1701964684; c=relaxed/simple;
        bh=uROcd/3U7rQgxurRGQN5VCfRLKooAspbAWHCadYtzyU=;
        h=DKIM-Signature:DKIM-Signature:Content-Type:Message-ID:Date:
         MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
         From:In-Reply-To; b=rb4bObY5Q4LBaNk/P8mBKDBEIGqu46jyz8PEc0V/rAN+U5GquJQxbPbvX90N1TaMm0IoBlrFLpLlwwVRbCaqZhYkhmnxkh17GH+Pf3nSM8NKJut/9ZDbg2IV0byfEDe8MMg5UZ7gPWKBavEstWtBvOX7kAMrLpt06xenGEQMNF7U60kR1nHCubbnVLrjie0d5HdUuGIeIPyXd6omAIH1SCVz0aabuJBeen6BxNvCtuSwGsdypXPzYjcIUgALkhqrVekqE3CNtrJMH4IcVtWOtM05gv92XJhYHQMdRvlLbilPiBDLKK9dsgY1AiqIDYFtGikuu6bLbK7aVi6KYuL7pA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701964684;
 h=content-type : message-id : date : mime-version : subject : to : cc
 : references : from : in-reply-to : from;
 bh=NE5F+XkmWiqyKfytJ561fU875aqUob9lyQJvt8LvMBU=;
 b=ofaaJwEmm5vNeCwr7f0EbpN3d5Tv6Kycu56lOvw7sW/UkMho0hcEg+Y1NTDj0tceZHv7h
 O/X3AU5x4W0V9XcAVwjg4IgYmZ2VycHaBKWNUgqiH1ZS9wN2bBTlZRtR1HkV/NNq4ZUqnVT
 U3Skuu1AhDpXUOU444nTre6W342PLRuQDtqg/c5pW0ljTMMHRkBJ2PIQ3F8+x3xMDr6OqgD
 AepgKLjPpqG0BB9UeQkjNxpua2j311mCxM3bdm2eraKYXVpxXQpUQWLD1lSNsvdP1DAixtp
 wV0EAjNU0Z5niugRa5Bi89wsLMriqMvzMJZBREZn7mtoAFv07KARjZOXBGXA==
Content-Type: multipart/mixed; boundary="------------7Ax4MydM3pHKUDdN0cmwlaxt"
Message-ID: <c866bcfa-85cc-44fb-9b54-bb4840f588e6@sapience.com>
Date:   Thu, 7 Dec 2023 10:58:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: md raid6 oops in 6.6.4 stable
Content-Language: en-US
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, snitzer@kernel.org,
        song@kernel.org, yukuai3@huawei.com, axboe@kernel.dk,
        mpatocka@redhat.com, heinzm@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Bhanu Victor DiCara <00bvd0+linux@gmail.com>,
        Xiao Ni <xni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me>
 <be56b5df-fef8-4dbe-bb98-f6370a692d6e@sapience.com>
 <714b22c7-b8dd-008d-a1ea-a184dc8ec1cf@linux.dev>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <714b22c7-b8dd-008d-a1ea-a184dc8ec1cf@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7Ax4MydM3pHKUDdN0cmwlaxt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/7/23 09:42, Guoqing Jiang wrote:
> Hi,
> 
> On 12/7/23 21:55, Genes Lists wrote:
>> On 12/7/23 08:30, Bagas Sanjaya wrote:
>>> On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
>>>> I have not had chance to git bisect this but since it happened in 
>>>> stable I
>>>> thought it was important to share sooner than later.
>>>>
>>>> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>>>>
>>>>    commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>>>>    Author: Song Liu <song@kernel.org>
>>>>    Date:   Fri Nov 17 15:56:30 2023 -0800
>>>>
>>>>      md: fix bi_status reporting in md_end_clone_io
>>>>
>>>> log attached shows page_fault_oops.
>>>> Machine was up for 3 days before crash happened.
> 
> Could you decode the oops (I can't find it in lore for some reason) 
> ([1])? And
> can it be reproduced reliably? If so, pls share the reproduce step.
> 
> [1]. https://lwn.net/Articles/592724/
> 
> Thanks,
> Guoqing

   - reproducing
     An rsync runs 2 x / day. It copies to this server from another. The 
copy is from a (large) top level directory. On the 3rd day after booting 
6.6.4,  the second of these rysnc's triggered the oops. I need to do 
more testing to see if I can reliably reproduce. I have not seen this 
oops on earlier stable kernels.

   - decoding oops with scripts/decode_stacktrace.sh had errors :
    readelf: Error: Not an ELF file - it has the wrong magic bytes at 
the start

    It appears that the decode script doesn't handle compressed modules. 
  I changed the readelf line to decompress first. This fixes the above 
script complaint and the result is attached.

gene






--------------7Ax4MydM3pHKUDdN0cmwlaxt
Content-Type: text/plain; charset=UTF-8; name="raid6-stacktrace"
Content-Disposition: attachment; filename="raid6-stacktrace"
Content-Transfer-Encoding: base64

RGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2Ug
ZmF1bHQgZm9yIGFkZHJlc3M6IGZmZmY4ODgxMDE5MzEyZTgKRGVjIDA2IDE5OjIwOjU0IHM2
IGtlcm5lbDogI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpE
ZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiAjUEY6IGVycm9yX2NvZGUoMHgwMDAzKSAtIHBl
cm1pc3Npb25zIHZpb2xhdGlvbgpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBQR0QgMzM2
ZTAxMDY3IFA0RCAzMzZlMDEwNjcgUFVEIDEwMTllZTA2MyBQTUQgMTAxOWYwMDYzIFBURSA4
MDAwMDAwMTAxOTMxMDIxCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IE9vcHM6IDAwMDMg
WyMxXSBQUkVFTVBUIFNNUCBQVEkKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogQ1BVOiAz
IFBJRDogNzczIENvbW06IG1kMTI3X3JhaWQ2IE5vdCB0YWludGVkIDYuNi40LXN0YWJsZS0x
ICM0IDc4NGMxYzcxMDY0NmNmZmMxZThjYzU5NzhmOGY2Y2VjOTc0YWExNzkKRGVjIDA2IDE5
OjIwOjU0IHM2IGtlcm5lbDogSGFyZHdhcmUgbmFtZTogVG8gQmUgRmlsbGVkIEJ5IE8uRS5N
LiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uL1ozNzAgRXh0cmVtZTQsIEJJT1MgUDQuMjAgMTAv
MzEvMjAxOQpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBSSVA6IHVwZGF0ZV9pb190aWNr
cysweDJjLzB4NjAgCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IENvZGU6IDFmIDAwIDBm
IDFmIDQ0IDAwIDAwIDQ4IDhiIDRmIDI4IDQ4IDM5IGYxIDc4IDE3IDgwIDdmIDMxIDAwIDc0
IDNiIDQ4IDhiIDQ3IDEwIDQ4IDhiIDc4IDQwIDQ4IDhiIDRmIDI4IDQ4IDM5IGYxIDc5IGU5
IDQ4IDg5IGM4IDxmMD4gNDggMGYgYjEgNzcgMjggNzUgZGUgNDggODkgZjAgNDggMjkgYzgg
ODQgZDIgYjkgMDEgMDAgPgpBbGwgY29kZQo9PT09PT09PQogICAwOgkxZiAgICAgICAgICAg
ICAgICAgICAJKGJhZCkKICAgMToJMDAgMGYgICAgICAgICAgICAgICAgCWFkZCAgICAlY2ws
KCVyZGkpCiAgIDM6CTFmICAgICAgICAgICAgICAgICAgIAkoYmFkKQogICA0Ogk0NCAwMCAw
MCAgICAgICAgICAgICAJYWRkICAgICVyOGIsKCVyYXgpCiAgIDc6CTQ4IDhiIDRmIDI4ICAg
ICAgICAgIAltb3YgICAgMHgyOCglcmRpKSwlcmN4CiAgIGI6CTQ4IDM5IGYxICAgICAgICAg
ICAgIAljbXAgICAgJXJzaSwlcmN4CiAgIGU6CTc4IDE3ICAgICAgICAgICAgICAgIAlqcyAg
ICAgMHgyNwogIDEwOgk4MCA3ZiAzMSAwMCAgICAgICAgICAJY21wYiAgICQweDAsMHgzMSgl
cmRpKQogIDE0Ogk3NCAzYiAgICAgICAgICAgICAgICAJamUgICAgIDB4NTEKICAxNjoJNDgg
OGIgNDcgMTAgICAgICAgICAgCW1vdiAgICAweDEwKCVyZGkpLCVyYXgKICAxYToJNDggOGIg
NzggNDAgICAgICAgICAgCW1vdiAgICAweDQwKCVyYXgpLCVyZGkKICAxZToJNDggOGIgNGYg
MjggICAgICAgICAgCW1vdiAgICAweDI4KCVyZGkpLCVyY3gKICAyMjoJNDggMzkgZjEgICAg
ICAgICAgICAgCWNtcCAgICAlcnNpLCVyY3gKICAyNToJNzkgZTkgICAgICAgICAgICAgICAg
CWpucyAgICAweDEwCiAgMjc6CTQ4IDg5IGM4ICAgICAgICAgICAgIAltb3YgICAgJXJjeCwl
cmF4CiAgMmE6KglmMCA0OCAwZiBiMSA3NyAyOCAgICAJbG9jayBjbXB4Y2hnICVyc2ksMHgy
OCglcmRpKQkJPC0tIHRyYXBwaW5nIGluc3RydWN0aW9uCiAgMzA6CTc1IGRlICAgICAgICAg
ICAgICAgIAlqbmUgICAgMHgxMAogIDMyOgk0OCA4OSBmMCAgICAgICAgICAgICAJbW92ICAg
ICVyc2ksJXJheAogIDM1Ogk0OCAyOSBjOCAgICAgICAgICAgICAJc3ViICAgICVyY3gsJXJh
eAogIDM4Ogk4NCBkMiAgICAgICAgICAgICAgICAJdGVzdCAgICVkbCwlZGwKICAzYToJYjkg
ICAgICAgICAgICAgICAgICAgCS5ieXRlIDB4YjkKICAzYjoJMDEgMDAgICAgICAgICAgICAg
ICAgCWFkZCAgICAlZWF4LCglcmF4KQoJLi4uCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZh
dWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KICAgMDoJZjAgNDggMGYgYjEgNzcgMjggICAgCWxvY2sgY21weGNoZyAlcnNp
LDB4MjgoJXJkaSkKICAgNjoJNzUgZGUgICAgICAgICAgICAgICAgCWpuZSAgICAweGZmZmZm
ZmZmZmZmZmZmZTYKICAgODoJNDggODkgZjAgICAgICAgICAgICAgCW1vdiAgICAlcnNpLCVy
YXgKICAgYjoJNDggMjkgYzggICAgICAgICAgICAgCXN1YiAgICAlcmN4LCVyYXgKICAgZToJ
ODQgZDIgICAgICAgICAgICAgICAgCXRlc3QgICAlZGwsJWRsCiAgMTA6CWI5ICAgICAgICAg
ICAgICAgICAgIAkuYnl0ZSAweGI5CiAgMTE6CTAxIDAwICAgICAgICAgICAgICAgIAlhZGQg
ICAgJWVheCwoJXJheCkKCS4uLgpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBSU1A6IDAw
MTg6ZmZmZmM5MDAwMGMwYmI3OCBFRkxBR1M6IDAwMDEwMjk2CkRlYyAwNiAxOToyMDo1NCBz
NiBrZXJuZWw6IFJBWDogY2NjY2NjY2NjY2NjY2NjYyBSQlg6IGZmZmY4ODgxMDE5MzEyYzAg
UkNYOiBjY2NjY2NjY2NjY2NjY2NjCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IFJEWDog
MDAwMDAwMDAwMDAwMDAwMSBSU0k6IDAwMDAwMDAxMTBmMjhmNGUgUkRJOiBmZmZmODg4MTAx
OTMxMmMwCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IFJCUDogMDAwMDAwMDAwMDAwMDAw
MSBSMDg6IGZmZmY4ODgxMDRjYzE3NjAgUjA5OiAwMDAwMDAwMDgwMjAwMDE2CkRlYyAwNiAx
OToyMDo1NCBzNiBrZXJuZWw6IFIxMDogZmZmZjg4ODUxZjBjZWQwMCBSMTE6IGZmZmY4ODg4
YmVmZmIwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDA4CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJu
ZWw6IFIxMzogMDAwMDAwMDAwMDAwMDAyOCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDggUjE1OiAw
MDAwMDAwMDAwMDAwMDQ4CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IEZTOiAgMDAwMDAw
MDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4ODllZWMwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpEZWMgMDYgMTk6MjA6NTQgczYg
a2VybmVsOiBDUjI6IGZmZmY4ODgxMDE5MzEyZTggQ1IzOiAwMDAwMDAwMzM2MDIwMDAyIENS
NDogMDAwMDAwMDAwMDM3MDZlMApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBEUjA6IDAw
MDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAw
MDAwMApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBEUjM6IDAwMDAwMDAwMDAwMDAwMDAg
RFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMApEZWMgMDYgMTk6
MjA6NTQgczYga2VybmVsOiBDYWxsIFRyYWNlOgpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVs
OiAgPFRBU0s+CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6ID8gX19kaWUrMHgyMy8weDcw
IApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiA/IHBhZ2VfZmF1bHRfb29wcysweDE3MS8w
eDRlMCAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogPyBleGNfcGFnZV9mYXVsdCsweDE3
NS8weDE4MCAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogPyBhc21fZXhjX3BhZ2VfZmF1
bHQrMHgyNi8weDMwIApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiA/IHVwZGF0ZV9pb190
aWNrcysweDJjLzB4NjAgCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IGJkZXZfZW5kX2lv
X2FjY3QrMHg2My8weDE2MCAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogbWRfZW5kX2Ns
b25lX2lvKzB4NzUvMHhhMCBtZF9tb2QKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogaGFu
ZGxlX3N0cmlwZV9jbGVhbl9ldmVudCsweDFlZS8weDQzMCByYWlkNDU2CkRlYyAwNiAxOToy
MDo1NCBzNiBrZXJuZWw6IGhhbmRsZV9zdHJpcGUrMHg3YjYvMHgxYWMwIHJhaWQ0NTYKRGVj
IDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogaGFuZGxlX2FjdGl2ZV9zdHJpcGVzLmlzcmEuMCsw
eDM4ZC8weDU1MCByYWlkNDU2CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IHJhaWQ1ZCsw
eDQ4OC8weDc1MCByYWlkNDU2CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6ID8gbG9ja190
aW1lcl9iYXNlKzB4NjEvMHg4MCAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogPyBwcmVw
YXJlX3RvX3dhaXRfZXZlbnQrMHg2MC8weDE4MCAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5l
bDogPyBfX3BmeF9tZF90aHJlYWQrMHgxMC8weDEwIG1kX21vZApEZWMgMDYgMTk6MjA6NTQg
czYga2VybmVsOiBtZF90aHJlYWQrMHhhYi8weDE5MCBtZF9tb2QKRGVjIDA2IDE5OjIwOjU0
IHM2IGtlcm5lbDogPyBfX3BmeF9hdXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24rMHgxMC8weDEw
IApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBrdGhyZWFkKzB4ZTUvMHgxMjAgCkRlYyAw
NiAxOToyMDo1NCBzNiBrZXJuZWw6ID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAgCkRlYyAw
NiAxOToyMDo1NCBzNiBrZXJuZWw6IHJldF9mcm9tX2ZvcmsrMHgzMS8weDUwIApEZWMgMDYg
MTk6MjA6NTQgczYga2VybmVsOiA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwIApEZWMgMDYg
MTk6MjA6NTQgczYga2VybmVsOiByZXRfZnJvbV9mb3JrX2FzbSsweDFiLzB4MzAgCkRlYyAw
NiAxOToyMDo1NCBzNiBrZXJuZWw6ICA8L1RBU0s+CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJu
ZWw6IE1vZHVsZXMgbGlua2VkIGluOiBhbGdpZl9oYXNoIGFmX2FsZyBtcHRjcF9kaWFnIHhz
a19kaWFnIHRjcF9kaWFnIHVkcF9kaWFnIHJhd19kaWFnIGluZXRfZGlhZyB1bml4X2RpYWcg
YWZfcGFja2V0X2RpYWcgbmV0bGlua19kaWFnIHJwY3NlY19nc3Nfa3JiNSBuZnN2NCBkbnNf
cmVzb2x2ZXIgbmZzIGZzY2FjaGUgbmV0ZnMgbmZ0X2N0PgpEZWMgMDYgMTk6MjA6NTQgczYg
a2VybmVsOiAgc25kX2hkYV9jb2RlYyBrdm0gc25kX2hkYV9jb3JlIGRybV9idWRkeSBzbmRf
aHdkZXAgaVRDT193ZHQgaTJjX2FsZ29fYml0IG1laV9weHAgaW50ZWxfcG1jX2J4dCBzbmRf
cGNtIG1laV9oZGNwIGVlMTAwNCBpcnFieXBhc3MgdHRtIGlUQ09fdmVuZG9yX3N1cHBvcnQg
cmFwbCBkcm1fZGlzcGxheV9oZWxwZXIgbmxzX2lzbzg4NTlfMT4KRGVjIDA2IDE5OjIwOjU0
IHM2IGtlcm5lbDogQ1IyOiBmZmZmODg4MTAxOTMxMmU4CkRlYyAwNiAxOToyMDo1NCBzNiBr
ZXJuZWw6IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQoK

--------------7Ax4MydM3pHKUDdN0cmwlaxt--
