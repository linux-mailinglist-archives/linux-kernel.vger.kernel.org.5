Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53227FB561
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjK1JPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjK1JPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:15:39 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6F05AB;
        Tue, 28 Nov 2023 01:15:42 -0800 (PST)
Received: from dinghao.liu$zju.edu.cn ( [10.190.69.212] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 28 Nov 2023 17:15:03 +0800
 (GMT+08:00)
X-Originating-IP: [10.190.69.212]
Date:   Tue, 28 Nov 2023 17:15:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Tariq Toukan" <ttoukan.linux@gmail.com>
Cc:     "Saeed Mahameed" <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Zhengchao Shao" <shaozhengchao@huawei.com>,
        "Rahul Rameshbabu" <rrameshbabu@nvidia.com>,
        "Simon Horman" <horms@kernel.org>,
        "Tariq Toukan" <tariqt@nvidia.com>, "Aya Levin" <ayal@nvidia.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix a potential double-free in
 fs_any_create_groups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <3d3b6a1f-40b6-45b5-a899-d01acb91213d@gmail.com>
References: <20231128082812.24483-1-dinghao.liu@zju.edu.cn>
 <3d3b6a1f-40b6-45b5-a899-d01acb91213d@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <18fac281.ae29.18c1535e9b4.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgB37o2Zr2Vlprk0AA--.5162W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsIBmVfIgMaAQAgsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiBPbiAyOC8xMS8yMDIzIDEwOjI4LCBEaW5naGFvIExpdSB3cm90ZToKPiA+IFdoZW4ga2Nh
bGxvYygpIGZvciBmdC0+ZyBzdWNjZWVkcyBidXQga3Z6YWxsb2MoKSBmb3IgaW4gZmFpbHMsCj4g
PiBmc19hbnlfY3JlYXRlX2dyb3VwcygpIHdpbGwgZnJlZSBmdC0+Zy4gSG93ZXZlciwgaXRzIGNh
bGxlcgo+ID4gZnNfYW55X2NyZWF0ZV90YWJsZSgpIHdpbGwgZnJlZSBmdC0+ZyBhZ2FpbiB0aHJv
dWdoIGNhbGxpbmcKPiA+IG1seDVlX2Rlc3Ryb3lfZmxvd190YWJsZSgpLCB3aGljaCB3aWxsIGxl
YWQgdG8gYSBkb3VibGUtZnJlZS4KPiA+IEZpeCB0aGlzIGJ5IHJlbW92aW5nIHRoZSBrZnJlZShm
dC0+ZykgaW4gZnNfYW55X2NyZWF0ZV9ncm91cHMoKS4KPiA+IAo+ID4gRml4ZXM6IDBmNTc1YzIw
YmYwNiAoIm5ldC9tbHg1ZTogSW50cm9kdWNlIEZsb3cgU3RlZXJpbmcgQU5ZIEFQSSIpCj4gPiBT
aWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4KPiA+IC0t
LQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4vZnNfdHRf
cmVkaXJlY3QuYyB8IDEgLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3Jl
L2VuL2ZzX3R0X3JlZGlyZWN0LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW4vZnNfdHRfcmVkaXJlY3QuYwo+ID4gaW5kZXggYmU4M2FkOWRiODJhLi5iMjIyZDIz
YmZiOWEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW4vZnNfdHRfcmVkaXJlY3QuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuL2ZzX3R0X3JlZGlyZWN0LmMKPiA+IEBAIC00MzQsNyArNDM0
LDYgQEAgc3RhdGljIGludCBmc19hbnlfY3JlYXRlX2dyb3VwcyhzdHJ1Y3QgbWx4NWVfZmxvd190
YWJsZSAqZnQpCj4gPiAgIAlmdC0+ZyA9IGtjYWxsb2MoTUxYNUVfRlNfVURQX05VTV9HUk9VUFMs
IHNpemVvZigqZnQtPmcpLCBHRlBfS0VSTkVMKTsKPiA+ICAgCWluID0ga3Z6YWxsb2MoaW5sZW4s
IEdGUF9LRVJORUwpOwo+ID4gICAJaWYgICghaW4gfHwgIWZ0LT5nKSB7Cj4gPiAtCQlrZnJlZShm
dC0+Zyk7Cj4gPiAgIAkJa3ZmcmVlKGluKTsKPiA+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiA+ICAg
CX0KPiAKPiBGdW5jdGlvbiBmc19hbnlfY3JlYXRlX2dyb3VwcyBzaG91bGQgbm90IHJldHVybiBm
YWlsdXJlIHdpdGhvdXQgY2xlYW5pbmcgCj4gaXRzZWxmIHVwLiBUaGlzIGlzIG5vdCB0aGUgcmln
aHQgZml4Lgo+IEZyZWVpbmcgZnQtPmcgYW5kIHNldHRpbmcgaXQgdG8gTlVMTCB3aWxsIGRvIGl0
LCBhbmQgd2lsbCBhdm9pZCB0aGUgCj4gZG91YmxlIGZyZWUuCgpUaGFua3MgZm9yIHlvdXIgYWR2
aWNlISBJIHdpbGwgcmVzZW5kIGEgbmV3IHBhdGNoIHNvb24uCgpSZWdhcmRzLApEaW5naGFv
