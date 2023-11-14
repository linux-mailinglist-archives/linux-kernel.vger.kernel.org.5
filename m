Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03557EA98A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjKNEcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjKNEcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:32:04 -0500
Received: from m1396.mail.163.com (m1396.mail.163.com [220.181.13.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8840FD49
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=eTgTzkwRMYce5WhYO0ZMUB0IQPgQEeP4HKrPGJksQH4=; b=m
        Y+Tb1fZSScranVrkLvuWjioTqe1oVzqivxnhW5KYmwY/Tg9dMvgVW+ACMlXxdTwl
        wyyT82YreQ560oc0RvcJ3kqbflqxsiJ8HCTu6z8AGoTG2xken79TH7WYQytME42n
        fxAOSRRYrL9yLyxufNcLDq6wLVfWNt2kmriDoWQmw4=
Received: from 00107082$163.com ( [111.35.186.243] ) by ajax-webmail-wmsvr96
 (Coremail) ; Tue, 14 Nov 2023 12:31:12 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Tue, 14 Nov 2023 12:31:12 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Regression or Fix]perf: profiling stats sigificantly changed for
 aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuySC/WYuUos5CSZYOkXn0oTju85XMCzuv8j3YJeN500kSrK1AkRWlleF3rz4em0MTyWlj6nbx1X0OlBRK9Ebp/h+AxE6wR1p8UaELO2aVLz
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: YMGowADnj00R+FJloUIgAA--.34439W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEAUoql8YMc69BgAJsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCgpJIHdhcyBtYWtpbmcga2VybmVsIHByb2ZpbGluZyB0byBpZGVudGlmeSBrZXJuZWwgY2hh
bmdlcyBiZXR3ZWVuIHJldmlzaW9ucyB1bmRlciB0aGUgbG9hZCBvZiBmaW8gYmVuY2htYXJrLCAK
VGhlIHByb2ZpbGVyIHVzZSBwZXJmX2V2ZW50X29wZW4gd2l0aCBhIGNncm91cCB3aGVyZSBhIGZp
byBydW4gYSAxMG1pbnV0ZXMgc3RyZXNzOiAgZmlvIC0tcmFuZHJlcGVhdD0xIC0taW9lbmdpbmU9
bGliYWlvIC0tZGlyZWN0PTEgLS1uYW1lPXRlc3QgIC0tYnM9NGsgLS1pb2RlcHRoPTY0IC0tc2l6
ZT0xRyAtLXJlYWR3cml0ZT1yYW5kcncgIC0tcnVudGltZT02MDAgLS1udW1qb2JzPTQgLS10aW1l
X2Jhc2VkPTEKCkkgbm90aWNlIGEgfjQlIGNoYW5nZSBpbiB0aGUgcHJvZmlsaW5nIGRhdGEuClRo
ZSBwcm9maWxpbmcgc3RhdCBmb3IgNi42LjA6CgphaW9fd3JpdGUoNTQuOTc0JSAxMTcxNTMvMjEz
MTA4KQogICAgZXh0NF9maWxlX3dyaXRlX2l0ZXIoOTcuMzk1JSAxMTQxMDEvMTE3MTUzKQogICAg
ICAgIGlvbWFwX2Rpb19ydyg5MS4xOTUlIDEwNDA1NC8xMTQxMDEpCiAgICAgICAgICAgIF9faW9t
YXBfZGlvX3J3KDk5LjgzNSUgMTAzODgyLzEwNDA1NCkKICAgICAgICAgICAgICAgIGlvbWFwX2Rp
b19iaW9faXRlcig2OC44MDAlIDcxNDcxLzEwMzg4MikgIDw8LS0tCiAgICAgICAgICAgICAgICBi
bGtfZmluaXNoX3BsdWcoMjIuMTQ2JSAyMzAwNi8xMDM4ODIpICAgPDwtLS0KICAgICAgICAgICAg
ICAgIGlvbWFwX2l0ZXIoNi4xNjElIDY0MDAvMTAzODgyKQogICAgICAgICAgICAgICAga21hbGxv
Y190cmFjZSgwLjg1MCUgODgzLzEwMzg4MikKICAgICAgICAgICAgICAgIGtpb2NiX2ludmFsaWRh
dGVfcGFnZXMoMC4yMDUlIDIxMy8xMDM4ODIpCiAgICAgICAgICAgICAgICBpbnZhbGlkYXRlX2lu
b2RlX3BhZ2VzMl9yYW5nZSgwLjEzMCUgMTM1LzEwMzg4MikKICAgICAgICAgICAgICAgIHNyc29f
cmV0dXJuX3RodW5rKDAuMTA5JSAxMTMvMTAzODgyKQoKCkFuZCBmb3IgNi43LjAtcmMxCgphaW9f
d3JpdGUoNTQuMzE3JSA5NjAzOS8xNzY4MTMpCiAgICBleHQ0X2ZpbGVfd3JpdGVfaXRlcig5Ny40
ODIlIDkzNjIxLzk2MDM5KQogICAgICAgIGlvbWFwX2Rpb19ydyg5MS4yMTElIDg1MzkzLzkzNjIx
KQogICAgICAgICAgICBfX2lvbWFwX2Rpb19ydyg5OS44MjIlIDg1MjQxLzg1MzkzKQogICAgICAg
ICAgICAgICAgaW9tYXBfZGlvX2Jpb19pdGVyKDY0Ljc5MyUgNTUyMzAvODUyNDEpICA8PC0tLS0t
CiAgICAgICAgICAgICAgICBibGtfZmluaXNoX3BsdWcoMjYuNDQ2JSAyMjU0My84NTI0MSkgIDw8
LS0tLQogICAgICAgICAgICAgICAgaW9tYXBfaXRlcig1Ljg4MSUgNTAxMy84NTI0MSkKICAgICAg
ICAgICAgICAgIGttYWxsb2NfdHJhY2UoMC42ODIlIDU4MS84NTI0MSkKICAgICAgICAgICAgICAg
IGtpb2NiX2ludmFsaWRhdGVfcGFnZXMoMC4yMzAlIDE5Ni84NTI0MSkKICAgICAgICAgICAgICAg
IGludmFsaWRhdGVfaW5vZGVfcGFnZXMyX3JhbmdlKDAuMTQ3JSAxMjUvODUyNDEpCgoKVGhlIGlv
bWFwX2Rpb19iaW9faXRlciBzYW1wbGVzIGRlY3JlYXNlIDQlIHdoaWxlIGJsa19maW5pc2hfcGx1
ZyBpbmNyZWFzZSA0JS4KCkkgaGF2ZSBydW4gYSBiaXNlY3QsIG5hcnJvdyBkb3duIHRvIGZvbGxv
d2luZyBjb21taXQ6CmNvbW1pdCBmMDZjYzY2N2Y3OTkwOWU5MTc1NDYwYjE2N2MyNzdiN2M2NGQz
ZGYwCkF1dGhvcjogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgpEYXRlOiAg
IE1vbiBPY3QgOSAyMzowNDoyNSAyMDIzICswMjAwCgogICAgcGVyZjogT3B0aW1pemUgcGVyZl9j
Z3JvdXBfc3dpdGNoKCkKCkFuZCBhZnRlciBJIHJldmVydCB0aGlzIGNvbW1pdCwgdGhlIHByb2Zp
bGluZyBzdGF0IG5vdyBhbG1vc3QgYWdyZWUgd2l0aCA2LjYuMAoKYWlvX3dyaXRlKDU0LjkzNyUg
MTA0NjkxLzE5MDU2NCkKICAgIGV4dDRfZmlsZV93cml0ZV9pdGVyKDk3LjU4NiUgMTAyMTY0LzEw
NDY5MSkKICAgICAgICBpb21hcF9kaW9fcncoOTEuMjU3JSA5MzIzMi8xMDIxNjQpCiAgICAgICAg
ICAgIF9faW9tYXBfZGlvX3J3KDk5LjgxOSUgOTMwNjMvOTMyMzIpCiAgICAgICAgICAgICAgICBp
b21hcF9kaW9fYmlvX2l0ZXIoNjkuNjU0JSA2NDgyMi85MzA2MykgPDwtLS0tLS0KICAgICAgICAg
ICAgICAgIGJsa19maW5pc2hfcGx1ZygyMS43MjQlIDIwMjE3LzkzMDYzKSAgPDwtLS0tCiAgICAg
ICAgICAgICAgICBpb21hcF9pdGVyKDUuODU5JSA1NDUzLzkzMDYzKQogICAgICAgICAgICAgICAg
a21hbGxvY190cmFjZSgwLjc1OCUgNzA1LzkzMDYzKQogICAgICAgICAgICAgICAga2lvY2JfaW52
YWxpZGF0ZV9wYWdlcygwLjI1MSUgMjM0LzkzMDYzKQogICAgICAgICAgICAgICAgaW52YWxpZGF0
ZV9pbm9kZV9wYWdlczJfcmFuZ2UoMC4xMzQlIDEyNS85MzA2MykKCgpJIGhhdmUgcnVuIHNldmVy
YWwgcm91bmQgb2YgdGVzdHMsIG1vc3RseSBkdXJpbmcgdGhlIGJpc2VjdCBwcm9jZXNzLCBhbmQg
dGhlIH40JSBjaGFuZ2UgaXMgY29uc2lzdGVudC4KVGhlIHByb2ZpbGVyIEkgdXNlZCBpcyBhbiBl
eHBlcmltZW50YWwgdG9vbCwgIG5vdCBwZXJmIHRob3VnaCwgSSB0aGluayB0aGUgYmVoYXZpb3Ig
Y2hhbmdlcyBpdCBkZXRlY3RlZCBpcyBsZWdpdC4gCmh0dHBzOi8vZ2l0aHViLmNvbS96cS1kYXZp
ZC13YW5nL2xpbnV4LXRvb2xzL2Jsb2IvbWFpbi9wZXJmL3Byb2ZpbGVyL3Byb2ZpbGVyLmNwcAoK
QnV0IEkgZGlkIG5vdCBub3RpY2UgYSBzaWduaWZpY2FudCBjaGFuZ2UgaW4gdGhlIG92ZXJoZWFk
IG9mIHBlcmYgdHJhY2luZyBiYXNlZCBvbiB0aGUgZmlvIHJlcG9ydCwgCnRoYXQgaXMgd2h5IEkg
YW0gbm90IHN1cmUgd2hldGhlciB0aGlzIGlzIGEgcmVncmVzc2lvbiBvciBhbiBpbXByb3ZlbWVu
dC4uLi4KSnVzdCByZXBvcnQgdGhlIGNoYW5nZS4KCgpUaGFua3MKRGF2aWQgV2FuZwog
