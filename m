Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697C07BC3D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjJGBgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJGBgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:36:18 -0400
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA7CAB6;
        Fri,  6 Oct 2023 18:36:14 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.190.65.233] ) by
 ajax-webmail-mail-app4 (Coremail) ; Sat, 7 Oct 2023 09:35:16 +0800
 (GMT+08:00)
X-Originating-IP: [10.190.65.233]
Date:   Sat, 7 Oct 2023 09:35:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Stefan Schmidt" <stefan@datenfreihafen.org>
Cc:     "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        stable@vger.kernel.org, "Alexander Aring" <alex.aring@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Harry Morris" <harrymorris12@gmail.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <1ed2f41f-ac5a-0b76-1012-410857d4da54@datenfreihafen.org>
References: <20231001054949.14624-1-dinghao.liu@zju.edu.cn>
 <202310011548.qyQMuodI-lkp@intel.com>
 <1ed2f41f-ac5a-0b76-1012-410857d4da54@datenfreihafen.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <364ac434.4e95.18b07c644b7.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCHWPXUtSBlDLgmAA--.2669W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIABmUexqIjNQAEsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gSGVsbG8gRGluZ2hhbywKPiAKPiAKPiBPbiAwMS4xMC4yMyAwOToxOSwga2VybmVsIHRlc3Qg
cm9ib3Qgd3JvdGU6Cj4gPiBIaSBEaW5naGFvLAo+ID4gCj4gPiBrZXJuZWwgdGVzdCByb2JvdCBu
b3RpY2VkIHRoZSBmb2xsb3dpbmcgYnVpbGQgd2FybmluZ3M6Cj4gPiAKPiA+IFthdXRvIGJ1aWxk
IHRlc3QgV0FSTklORyBvbiBsaW51cy9tYXN0ZXJdCj4gPiBbYWxzbyBidWlsZCB0ZXN0IFdBUk5J
Tkcgb24gdjYuNi1yYzMgbmV4dC0yMDIzMDkyOV0KPiA+IFtJZiB5b3VyIHBhdGNoIGlzIGFwcGxp
ZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVlLCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuCj4gPiBBbmQg
d2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBhcyBkb2N1
bWVudGVkIGluCj4gPiBodHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0LWZvcm1hdC1wYXRjaCNf
YmFzZV90cmVlX2luZm9ybWF0aW9uXQo+ID4gCj4gPiB1cmw6ICAgIGh0dHBzOi8vZ2l0aHViLmNv
bS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvRGluZ2hhby1MaXUvaWVlZTgwMjE1NC1jYTgy
MTAtRml4LWEtcG90ZW50aWFsLVVBRi1pbi1jYTgyMTBfcHJvYmUvMjAyMzEwMDEtMTM1MTMwCj4g
PiBiYXNlOiAgIGxpbnVzL21hc3Rlcgo+ID4gcGF0Y2ggbGluazogICAgaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDIzMTAwMTA1NDk0OS4xNDYyNC0xLWRpbmdoYW8ubGl1JTQwemp1LmVkdS5j
bgo+ID4gcGF0Y2ggc3ViamVjdDogW1BBVENIXSBbdjNdIGllZWU4MDIxNTQ6IGNhODIxMDogRml4
IGEgcG90ZW50aWFsIFVBRiBpbiBjYTgyMTBfcHJvYmUKPiA+IGNvbmZpZzogbTY4ay1hbGx5ZXNj
b25maWcgKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMTAwMS8y
MDIzMTAwMTE1NDgucXlRTXVvZEktbGtwQGludGVsLmNvbS9jb25maWcpCj4gPiBjb21waWxlcjog
bTY4ay1saW51eC1nY2MgKEdDQykgMTMuMi4wCj4gPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEg
YnVpbGQpOiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMxMDAx
LzIwMjMxMDAxMTU0OC5xeVFNdW9kSS1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkKPiA+IAo+ID4g
SWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90
IGp1c3QgYSBuZXcgdmVyc2lvbiBvZgo+ID4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5
IGFkZCBmb2xsb3dpbmcgdGFncwo+ID4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+Cj4gPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Ut
a2J1aWxkLWFsbC8yMDIzMTAwMTE1NDgucXlRTXVvZEktbGtwQGludGVsLmNvbS8KPiA+IAo+ID4g
QWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6Cj4gPiAKPiA+ICAgICBkcml2
ZXJzL25ldC9pZWVlODAyMTU0L2NhODIxMC5jOiBJbiBmdW5jdGlvbiAnY2E4MjEwX3JlZ2lzdGVy
X2V4dF9jbG9jayc6Cj4gPj4+IGRyaXZlcnMvbmV0L2llZWU4MDIxNTQvY2E4MjEwLmM6Mjc0Mzox
Mzogd2FybmluZzogdW51c2VkIHZhcmlhYmxlICdyZXQnIFstV3VudXNlZC12YXJpYWJsZV0KPiA+
ICAgICAgMjc0MyB8ICAgICAgICAgaW50IHJldCA9IDA7Cj4gPiAgICAgICAgICAgfCAgICAgICAg
ICAgICBefn4KPiA+IAo+IAo+IFBsZWFzZSB0YWtlIGNhcmUgb2YgdGhpcyBub3cgdW51c2VkIHZh
cmlhYmxlIGFmdGVyIHlvdXIgcmUtZmFjdG9yLgo+IFdpdGggdGhpcyBmaXhlZCBhbmQgc2VuZCBv
dXQgYXMgdjQgSSBhbSBoYXBweSB0byBnZXQgdGhpcyBhcHBsaWVkIHRvIHRoZSAKPiB3cGFuIHRy
ZWUuCgpJIHdpbGwgcmVzZW5kIHRoZSB2NCBwYXRjaCBzb29uLCB0aGFua3MhCgpSZWdhcmRzLApE
aW5naGFvCg==
