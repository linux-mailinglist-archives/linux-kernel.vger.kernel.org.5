Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21A760373
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGYAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:01:25 -0400
X-Greylist: delayed 144961 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 17:01:17 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8AF3173D;
        Mon, 24 Jul 2023 17:01:17 -0700 (PDT)
Received: from linma$zju.edu.cn ( [10.162.208.50] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 25 Jul 2023 08:00:48 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.208.50]
Date:   Tue, 25 Jul 2023 08:00:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Leon Romanovsky" <leon@kernel.org>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:  [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230724142155.13c83625@kernel.org>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
 <20230724174435.GA11388@unreal> <20230724142155.13c83625@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2c84a81c.e2620.1898a5930be.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDn74uwEL9k+TCACg--.39599W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIGEmS91fkARAARs1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmFrdWIsCgo+IE9uIE1vbiwgMjQgSnVsIDIwMjMgMjA6NDQ6MzUgKzAzMDAgTGVvbiBS
b21hbm92c2t5IHdyb3RlOgo+ID4gPiBAQCAtMTMxODYsNiArMTMxODYsOSBAQCBzdGF0aWMgaW50
IGk0MGVfbmRvX2JyaWRnZV9zZXRsaW5rKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiA+ICAJ
CWlmIChubGFfdHlwZShhdHRyKSAhPSBJRkxBX0JSSURHRV9NT0RFKQo+ID4gPiAgCQkJY29udGlu
dWU7Cj4gPiA+ICAKPiA+ID4gKwkJaWYgKG5sYV9sZW4oYXR0cikgPCBzaXplb2YobW9kZSkpCj4g
PiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsKPiA+ID4gKyAgCj4gPiAKPiA+IEkgc2VlIHRoYXQgeW91
IGFkZGVkIHRoaXMgaHVuayB0byBhbGwgdXNlcnMgb2YgbmxhX2Zvcl9lYWNoX25lc3RlZCgpLCBp
dAo+ID4gd2lsbCBiZSBncmVhdCB0byBtYWtlIHRoYXQgaXRlcmF0b3IgdG8gc2tpcCBzdWNoIGVt
cHR5IGF0dHJpYnV0ZXMuCj4gPiAKPiA+IEhvd2V2ZXIsIGkgZG9uJ3Qga25vdyBuZXR0bGluayBn
b29kIGVub3VnaCB0byBzYXkgaWYgeW91ciBjaGFuZ2UgaXMKPiA+IHZhbGlkIGluIGZpcnN0IHBs
YWNlLgo+IAo+IEVtcHR5IGF0dHJpYnV0ZXMgYXJlIHZhbGlkLCB3ZSBjYW4ndCBkbyB0aGF0Lgo+
IAo+IEJ1dCB0aGVyZSdzIGEgbG9vcCBpbiBydG5sX2JyaWRnZV9zZXRsaW5rKCkgd2hpY2ggY2hl
Y2tzIHRoZSBhdHRyaWJ1dGVzLgoKQ29vbCwgSSB3aWxsIGNoZWNrIHRoaXMgb3V0IGFuZCBwcmVw
YXJlIGFub3RoZXIgcGF0Y2guCgo+IFdlIGNhbiBhZGQgdGhlIGNoZWNrIHRoZXJlIGluc3RlYWQg
b2YgYWxsIHVzZXJzLCBhcyBMZW9uIHBvaW50cyBvdXQuCj4gKFBsZWFzZSBqdXN0IGRvdWJsZSBj
aGVjayB0aGF0IGFsbCBuZG9fYnJpZGdlX3NldGxpbmsgaW1wbGVtZW50YXRpb24KPiBleHBlY3Qg
dGhpcyB2YWx1ZSB0byBiZSBhIHUxNiwgdGhleSBzaG91bGQvKQoKT2theSwgSSB3aWxsIGZpbmlz
aCB0aGF0IEFTQVAKCj4gLS0gCj4gcHctYm90OiBjcgoKUmVnYXJkcwpMaW4=
