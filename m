Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20880B461
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjLIMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjLIMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:41:16 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86593A6;
        Sat,  9 Dec 2023 04:41:21 -0800 (PST)
Received: from dinghao.liu$zju.edu.cn ( [10.181.205.210] ) by
 ajax-webmail-mail-app4 (Coremail) ; Sat, 9 Dec 2023 20:40:54 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.205.210]
Date:   Sat, 9 Dec 2023 20:40:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Jakub Kicinski" <kuba@kernel.org>
Cc:     "Ariel Elior" <aelior@marvell.com>,
        "Manish Chopra" <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Yuval Mintz" <Yuval.Mintz@qlogic.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] qed: Fix a potential use-after-free in
 qed_cxt_tables_alloc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231208155957.088c372b@kernel.org>
References: <20231207093606.17868-1-dinghao.liu@zju.edu.cn>
 <20231208155957.088c372b@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <15e70d8.29a3c.18c4e985043.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgA3PDRWYHRl7WJrAA--.21118W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoEBmV0OhUDUwAAsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsICA3IERlYyAyMDIzIDE3OjM2OjA2ICswODAwIERpbmdoYW8gTGl1IHdyb3RlOgo+
ID4gdjI6IC1DaGFuZ2UgdGhlIGJ1ZyB0eXBlIGZyb20gZG91YmxlLWZyZWUgdG8gdXNlLWFmdGVy
LWZyZWUuCj4gPiAgICAgLU1vdmUgdGhlIG51bGwgY2hlY2sgYWdhaW5zdCBwX21uZ3ItPmlsdF9z
aGFkb3cgdG8gdGhlIGJlZ2lubmluZwo+ID4gICAgICBvZiB0aGUgZnVuY3Rpb24gcWVkX2lsdF9z
aGFkb3dfZnJlZSgpLgo+ID4gICAgIC1XaGVuIGtjYWxsb2MoKSBmYWlscyBpbiBxZWRfaWx0X3No
YWRvd19hbGxvYygpLCBqdXN0IHJldHVybgo+ID4gICAgICBiZWNhdXNlIHRoZXJlIGlzIG5vdGhp
bmcgdG8gZnJlZS4KPiAKPiBUaGlzIHJlZmFjdG9yaW5nIGlzIG5vdCBhY2NlcHRhYmxlIGFzIHBh
cnQgb2YgYSBmaXgsIHNvcnJ5Lgo+IAo+ID4gQEAgLTkzMyw2ICs5MzYsNyBAQCBzdGF0aWMgdm9p
ZCBxZWRfaWx0X3NoYWRvd19mcmVlKHN0cnVjdCBxZWRfaHdmbiAqcF9od2ZuKQo+ID4gIAkJcF9k
bWEtPnZpcnRfYWRkciA9IE5VTEw7Cj4gPiAgCX0KPiA+ICAJa2ZyZWUocF9tbmdyLT5pbHRfc2hh
ZG93KTsKPiA+ICsJcF9od2ZuLT5wX2N4dF9tbmdyLT5pbHRfc2hhZG93ID0gTlVMTDsKPiAKPiBX
aHkgZG8geW91IGRlcmVmZXJlbmNlIHBfaHdmbiBoZXJlPwo+IFNlZW1zIG1vcmUgbmF0dXJhbCB0
byB1c2U6Cj4gCj4gCXBfbW5nci0+aWx0X3NoYWRvdyA9IE5VTEw7Cj4gCj4gc2luY2UgdGhhdCdz
IHRoZSBleGFjdCBwb2ludGVyIHRoYXQgd2FzIHBhc3NlZCB0byBmcmVlLgo+IC0tIAo+IHB3LWJv
dDogY3IKCkkgd2lsbCByZXNlbmQgYSBuZXcgcGF0Y2ggdG8gZml4IHRoaXMsIHRoYW5rcyEKClJl
Z2FyZHMsCkRpbmdoYW8K
