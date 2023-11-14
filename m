Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14BF7EB361
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjKNPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:21:22 -0500
Received: from m1355.mail.163.com (m1355.mail.163.com [220.181.13.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DABCB11D;
        Tue, 14 Nov 2023 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=Ak9EaB59gyCEovqIJ4okvRmDFNn2Tsq6SQNmb/KynmA=; b=h
        szApbOkjvcouCNHA0UL3mcYCo94gsDOb0vzOEeHarESLt1heuH+mnfeXSmsRq9XI
        Q9X9jlJFsDC3o5c5zUmqYqH3i84LLT2f5Ak1ILffD2QcTwFh13ug9EYQOn6mgc28
        U6Y5WZyLu+KroSveuQBCEF0bDMFUi4M8Z6NwjbKHp8=
Received: from 00107082$163.com ( [111.35.186.243] ) by ajax-webmail-wmsvr55
 (Coremail) ; Tue, 14 Nov 2023 23:20:32 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Tue, 14 Nov 2023 23:20:32 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:[Regression or Fix]perf: profiling stats sigificantly changed
 for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
X-NTES-SC: AL_QuySC/Wcukoo5CidYOkXn0oTju85XMCzuv8j3YJeN500tyri5QwQR0VyH1LL4tuQJiWxiiKGbiFg28FDR5VFXKNVrSKz3rpiSPu6Zw1DOCNb
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: N8GowAD3n_tBkFNlYzYYAA--.57550W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTAEoqmI0cP8ufQAGsD
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

CgpBdCAyMDIzLTExLTE0IDEyOjMxOjEyLCAiRGF2aWQgV2FuZyIgPDAwMTA3MDgyQDE2My5jb20+
IHdyb3RlOgo+SGksCj4KPkkgd2FzIG1ha2luZyBrZXJuZWwgcHJvZmlsaW5nIHRvIGlkZW50aWZ5
IGtlcm5lbCBjaGFuZ2VzIGJldHdlZW4gcmV2aXNpb25zIHVuZGVyIHRoZSBsb2FkIG9mIGZpbyBi
ZW5jaG1hcmssIAoKPkJ1dCBJIGRpZCBub3Qgbm90aWNlIGEgc2lnbmlmaWNhbnQgY2hhbmdlIGlu
IHRoZSBvdmVyaGVhZCBvZiBwZXJmIHRyYWNpbmcgYmFzZWQgb24gdGhlIGZpbyByZXBvcnQsIAo+
dGhhdCBpcyB3aHkgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMgaXMgYSByZWdyZXNzaW9uIG9y
IGFuIGltcHJvdmVtZW50Li4uLgo+SnVzdCByZXBvcnQgdGhlIGNoYW5nZS4KPgoKSSBydW4gdGhl
IHNhbWUgdGVzdCBvbiBhbm90aGVyIGRpc2sgd2hpY2ggaXMgYWxtb3N0IGlkbGUgYWxsIHRoZSB0
aW1lLCBhbmQgc3RpbGwsIHNpZ25pZmljYW50IHBlcmYgc2FtcGxlIHN0YXRzIGNoYW5nZXMgZGV0
ZWN0ZWQ6Cgo2LjcuMC1yYzEKCmFpb193cml0ZSg0OS4zNDAlIDEzMTUwMS8yNjY1MjEpCiAgICBl
eHQ0X2ZpbGVfd3JpdGVfaXRlcig5NC41NjclIDEyNDM1Ni8xMzE1MDEpCiAgICAgICAgaW9tYXBf
ZGlvX3J3KDc4LjQ5NCUgOTc2MTIvMTI0MzU2KQogICAgICAgICAgICBfX2lvbWFwX2Rpb19ydyg5
OS41NTAlIDk3MTczLzk3NjEyKQogICAgICAgICAgICAgICAgaW9tYXBfZGlvX2Jpb19pdGVyKDQ3
Ljc3MyUgNDY0MjIvOTcxNzMpICAgPDwtLS0tCiAgICAgICAgICAgICAgICBibGtfZmluaXNoX3Bs
dWcoMjkuOTMxJSAyOTA4NS85NzE3MykgICAgICA8PC0tLS0KICAgICAgICAgICAgICAgIGlvbWFw
X2l0ZXIoMTQuMDgyJSAxMzY4NC85NzE3MykKICAgICAgICAgICAgICAgIGttYWxsb2NfdHJhY2Uo
MS44MTQlIDE3NjMvOTcxNzMpCiAgICAgICAgICAgICAgICBraW9jYl9pbnZhbGlkYXRlX3BhZ2Vz
KDAuNjMxJSA2MTMvOTcxNzMpCiAgICAgICAgICAgICAgICBpbnZhbGlkYXRlX2lub2RlX3BhZ2Vz
Ml9yYW5nZSgwLjQ0OCUgNDM1Lzk3MTczKQogICAgICAgICAgICAgICAgc3Jzb19yZXR1cm5fdGh1
bmsoMC4zMjAlIDMxMS85NzE3MykKICAgICAgICAgICAgICAgIGJsa19zdGFydF9wbHVnKDAuMTY3
JSAxNjIvOTcxNzMpCgoKNi43LjAtcmMxIHdpdGggZjA2Y2M2NjdmNzkgcmV2ZXJ0ZWQKCmFpb193
cml0ZSg0OS4wNzElIDE1NTg3My8zMTc2NDkpCiAgICBleHQ0X2ZpbGVfd3JpdGVfaXRlcig5NS4y
MTElIDE0ODQwOS8xNTU4NzMpCiAgICAgICAgaW9tYXBfZGlvX3J3KDgxLjgxNiUgMTIxNDIyLzE0
ODQwOSkKICAgICAgICAgICAgX19pb21hcF9kaW9fcncoOTkuNjg0JSAxMjEwMzgvMTIxNDIyKQog
ICAgICAgICAgICAgICAgaW9tYXBfZGlvX2Jpb19pdGVyKDQwLjI4MCUgNDg3NTQvMTIxMDM4KSAg
IDw8LS0tCiAgICAgICAgICAgICAgICBibGtfZmluaXNoX3BsdWcoMzYuNzYwJSA0NDQ5NC8xMjEw
MzgpICAgICAgPDwtLS0KICAgICAgICAgICAgICAgIGlvbWFwX2l0ZXIoMTQuNjU3JSAxNzc0MC8x
MjEwMzgpCiAgICAgICAgICAgICAgICBrbWFsbG9jX3RyYWNlKDEuNzc1JSAyMTQ5LzEyMTAzOCkK
ICAgICAgICAgICAgICAgIGtpb2NiX2ludmFsaWRhdGVfcGFnZXMoMC41OTklIDcyNS8xMjEwMzgp
CiAgICAgICAgICAgICAgICBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzMl9yYW5nZSgwLjMzMCUgMzk5
LzEyMTAzOCkKICAgICAgICAgICAgICAgIHNyc29fcmV0dXJuX3RodW5rKDAuMjYzJSAzMTgvMTIx
MDM4KQogICAgICAgICAgICAgICAgYmxrX3N0YXJ0X3BsdWcoMC4xNjklIDIwNC8xMjEwMzgpCgoK
SSByZW1vdmUgdGhlIDQgb2NjdXJyZW5jZXMgZm9yIGNoZWNraW5nIG5yX2Nncm91cHM6CgpkaWZm
IC0tZ2l0IGEva2VybmVsL2V2ZW50cy9jb3JlLmMgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYwppbmRl
eCA2ODNkYzA4NmVmMTAuLjc1ODM0MThlOTRkOSAxMDA2NDQKLS0tIGEva2VybmVsL2V2ZW50cy9j
b3JlLmMKKysrIGIva2VybmVsL2V2ZW50cy9jb3JlLmMKQEAgLTY5MCw4ICs2OTAsOCBAQCBzdGF0
aWMgdm9pZCBwZXJmX2N0eF9kaXNhYmxlKHN0cnVjdCBwZXJmX2V2ZW50X2NvbnRleHQgKmN0eCwg
Ym9vbCBjZ3JvdXApCiAgICAgICAgc3RydWN0IHBlcmZfZXZlbnRfcG11X2NvbnRleHQgKnBtdV9j
dHg7CiAKICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBtdV9jdHgsICZjdHgtPnBtdV9jdHhf
bGlzdCwgcG11X2N0eF9lbnRyeSkgewotICAgICAgICAgICAgICAgaWYgKGNncm91cCAmJiAhcG11
X2N0eC0+bnJfY2dyb3VwcykKLSAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7CisgICAg
ICAgLy8gICAgICBpZiAoY2dyb3VwICYmICFwbXVfY3R4LT5ucl9jZ3JvdXBzKQorICAgICAgIC8v
ICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgICAgIHBlcmZfcG11X2Rpc2FibGUo
cG11X2N0eC0+cG11KTsKICAgICAgICB9CiB9CkBAIC03MDEsOCArNzAxLDggQEAgc3RhdGljIHZv
aWQgcGVyZl9jdHhfZW5hYmxlKHN0cnVjdCBwZXJmX2V2ZW50X2NvbnRleHQgKmN0eCwgYm9vbCBj
Z3JvdXApCiAgICAgICAgc3RydWN0IHBlcmZfZXZlbnRfcG11X2NvbnRleHQgKnBtdV9jdHg7CiAK
ICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBtdV9jdHgsICZjdHgtPnBtdV9jdHhfbGlzdCwg
cG11X2N0eF9lbnRyeSkgewotICAgICAgICAgICAgICAgaWYgKGNncm91cCAmJiAhcG11X2N0eC0+
bnJfY2dyb3VwcykKLSAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7CisgICAgICAgLy8g
ICAgICBpZiAoY2dyb3VwICYmICFwbXVfY3R4LT5ucl9jZ3JvdXBzKQorICAgICAgIC8vICAgICAg
ICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgICAgIHBlcmZfcG11X2VuYWJsZShwbXVfY3R4
LT5wbXUpOwogICAgICAgIH0KIH0KQEAgLTMzMDcsOCArMzMwNyw4IEBAIGN0eF9zY2hlZF9vdXQo
c3RydWN0IHBlcmZfZXZlbnRfY29udGV4dCAqY3R4LCBlbnVtIGV2ZW50X3R5cGVfdCBldmVudF90
eXBlKQogICAgICAgIGlzX2FjdGl2ZSBePSBjdHgtPmlzX2FjdGl2ZTsgLyogY2hhbmdlZCBiaXRz
ICovCiAKICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBtdV9jdHgsICZjdHgtPnBtdV9jdHhf
bGlzdCwgcG11X2N0eF9lbnRyeSkgewotICAgICAgICAgICAgICAgaWYgKGNncm91cCAmJiAhcG11
X2N0eC0+bnJfY2dyb3VwcykKLSAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7CisgICAg
ICAgLy8gICAgICBpZiAoY2dyb3VwICYmICFwbXVfY3R4LT5ucl9jZ3JvdXBzKQorICAgICAgIC8v
ICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgICAgIF9fcG11X2N0eF9zY2hlZF9v
dXQocG11X2N0eCwgaXNfYWN0aXZlKTsKICAgICAgICB9CiB9CgoKIFRoZSByZXN1bHRpbmcgcHJv
ZmlsaW5nIHN0YXRzIGlzIHNpbWlsYXIgdG8gcmV2ZXJ0aW5nIGYwNmNjNjY3Zjc5LgpJIHRoaW5r
IHRoZXJlIGFyZSBzb21lIGNhc2VzIHdoZXJlIHBtdV9jdHgtPm5yX2Nncm91cHMgaXMgemVybyBi
dXQgdGhlcmUgaXMgc3RpbGwgY2dyb3VwIGV2ZW50IHdpdGhpbiwgYW5kIHNvbWUgc2FtcGxlcyBh
cmUgbWlzc2VkLCBjYXVzaW5nIHRoZSBzdGF0cyBjaGFuZ2VzLCBqdXN0IGEgZ3Vlc3MuCgoKRGF2
aWQgV2FuZwoK
