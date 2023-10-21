Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F87D19DC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjJUATr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjJUATp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:19:45 -0400
Received: from m1311.mail.163.com (m1311.mail.163.com [220.181.13.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BF76D6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=bi2/jAtBO/R7DPkVzRfhSgvjTTTHe65pMfy/zIfTavA=; b=F
        Bx0co3a/BciTQg855NfD0AWyBLABcqj5buhD332uaXpbBTwAQLptmt5OVeCKjVPV
        QxRD7RT1Th1LVCld7dEerHq1/F3jkZ8jX9bWWPAxCCatuwAgNab2A08mDcdqMCFN
        kPZOdLNVTMvmTDJ+58VbzNWaaUOPjgDU+SOckbqLgE=
Received: from 00107082$163.com ( [111.35.185.232] ) by ajax-webmail-wmsvr11
 (Coremail) ; Sat, 21 Oct 2023 08:19:34 +0800 (CST)
X-Originating-IP: [111.35.185.232]
Date:   Sat, 21 Oct 2023 08:19:34 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PERFORMANCE]fs: sendfile suffer performance degradation when
 buffer size have performance impact on underling IO
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuySBfSfuE0s4iaYY+kXn0oTju85XMCzuv8j3YJeN500vinW3h4PbG9dHUPX7NOPCSKsoAi7eh9H7vpVcrhYdKYFLfxkO5652uZSTRLRuMUN
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <28de01eb.208.18b4f9a0051.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: C8GowAA3R1MXGTNle+YPAA--.41289W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEA8Qql8YL38cvgAEsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIAoKSSB3YXMgdHJ5aW5nIHRvIGNvbmZpcm0gdGhlIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50
IHZpYSByZXBsYWNpbmcgcmVhZC93cml0ZSBzZXF1ZW5jZXMgd2l0aCBzZW5kZmlsZSwgCkJ1dCBJ
IGdvdCBxdWl0ZSBhIHN1cnByaXNpbmcgcmVzdWx0OgoKJCBnY2MgLURVU0VfU0VOREZJTEUgY3Au
Y3BwCiQgdGltZSAuL2Eub3V0IAoKcmVhbAkwbTU2LjEyMXMKdXNlcgkwbTAuMDAwcwpzeXMJMG00
Ljg0NHMKCiQgZ2NjICBjcC5jcHAKJCB0aW1lIC4vYS5vdXQgCgpyZWFsCTBtMjcuMzYzcwp1c2Vy
CTBtMC4wMTRzCnN5cwkwbTQuNDQzcwoKVGhlIHJlc3VsdCBzaG93IHRoYXQsIGluIG15IHRlc3Qg
c2NlbmFyaW8sICB0aGUgcmVhZC93cml0ZSBzZXF1ZW5jZXMgb25seSB1c2UgaGFsZiBvZiB0aGUg
dGltZSBieSBzZW5kZmlsZS4KTXkgZ3Vlc3MgaXMgdGhhdCBzZW5kZmlsZSB1c2luZyBhIGRlZmF1
bHQgcGlwZSB3aXRoIGJ1ZmZlciBzaXplIDE8PDE2ICgxNiBwYWdlcyksIHdoaWNoIGlzIG5vdCB0
dW5lZCBmb3IgdGhlIHVuZGVybGluZyBJTywgCmhlbmNlIGEgcmVhZC93cml0ZSBzZXF1ZW5jZXMg
d2l0aCBidWZmZXIgc2l6ZSAxPDwxNyBpcyBtdWNoIGZhc3RlciB0aGFuIHNlbmRmaWxlLgoKQnV0
IHRoZSBwcm9ibGVtIHdpdGggc2VuZGZpbGUgaXMgdGhhdCB0aGVyZSBpcyBubyBwYXJhbWV0ZXIg
dG8gdHVuZSB0aGUgYnVmZmVyIHNpemUgZnJvbSB1c2Vyc3BhY2UuLi5BbnkgY2hhbmNlIHRvIGZp
eCB0aGlzPwoKVGhlIHRlc3QgY29kZSBpcyBhcyBmb2xsb3dpbmc6CgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxz
eXMvc3RhdC5oPgojaW5jbHVkZSA8c3lzL3NlbmRmaWxlLmg+CiNpbmNsdWRlIDxmY250bC5oPgoK
Y2hhciBidWZbMTw8MTddOyAgIC8vIG11Y2ggYmV0dGVyIHRoYW4gMTw8MTYKaW50IG1haW4oKSB7
CglpbnQgaSwgZmluLCBmb3V0LCBuLCBtOwoJZm9yIChpPTA7IGk8MTI4OyBpKyspIHsKCQkvLyBk
ZCBpZj0vZGV2L3VyYW5kb20gb2Y9Li9iaWdmaWxlIGJzPTEzMTA3MiBjb3VudD0yNTYKCQlmaW4g
ID0gb3BlbigiLi9iaWdmaWxlIiwgT19SRE9OTFkpOwoJCWZvdXQgPSBvcGVuKCIuL3RhcmdldCIs
IE9fV1JPTkxZIHwgT19DUkVBVCB8IE9fRFNZTkMsIFNfSVdVU1IpOwojaWZuZGVmIFVTRV9TRU5E
RklMRSAKCQl3aGlsZSgxKSB7CgkJCW4gPSByZWFkKGZpbiwgYnVmLCBzaXplb2YoYnVmKSk7CgkJ
CWlmIChuPT0wKSBicmVhazsKCQkJbSA9IHdyaXRlKGZvdXQsIGJ1Ziwgbik7CgkJCWlmIChuICE9
IG0pIHsKCQkJCXByaW50ZigiZmFpbCB0byB3cml0ZSwgZXhwZWN0ICVkLCBhY3R1YWwgJWRcbiIs
IG4sIG0pOwoJCQkJcGVycm9yKCI6Iik7CgkJCQlyZXR1cm4gMTsKCQkJfQoJCX0KI2Vsc2UKCQlv
ZmZfdCBvZmZzZXQgPSAwOwoJCXN0cnVjdCBzdGF0IHN0OwoJCWlmIChmc3RhdChmaW4sICZzdCkg
IT0gMCkgewoJCQlwZXJyb3IoImZhaWwgdG8gZnN0YXRcbiIpOwoJCQlyZXR1cm4gMTsKCQl9CgkJ
c2VuZGZpbGUoZm91dCwgZmluLCAmb2Zmc2V0LCBzdC5zdF9zaXplKTsKCiNlbmRpZgoJCWNsb3Nl
KGZpbik7CgkJY2xvc2UoZm91dCk7CgoJfQoJcmV0dXJuIDA7Cn0KCkZZSQpEYXZpZAoK
