Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E6804CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbjLEIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:47:18 -0500
X-Greylist: delayed 18583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 00:47:22 PST
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 053E4C0;
        Tue,  5 Dec 2023 00:47:21 -0800 (PST)
Received: from dinghao.liu$zju.edu.cn ( [10.190.70.5] ) by
 ajax-webmail-mail-app4 (Coremail) ; Tue, 5 Dec 2023 16:44:48 +0800
 (GMT+08:00)
X-Originating-IP: [10.190.70.5]
Date:   Tue, 5 Dec 2023 16:44:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Zhenyu Wang" <zhenyuw@linux.intel.com>
Cc:     "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Ian Rogers" <irogers@google.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Colin Ian King" <colin.i.king@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/uncore: fix a potential double-free in
 uncore_type_init
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZW7bWGy+ZhcBUo73@debian-scheme>
References: <20231205032709.9525-1-dinghao.liu@zju.edu.cn>
 <ZW7bWGy+ZhcBUo73@debian-scheme>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4e1e710a.1d65f.18c3926bb7d.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDHhtQA425l1FJOAA--.15055W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoTBmVsUQg4xgASsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMDIzLjEyLjA1IDExOjI3OjA5ICswODAwLCBEaW5naGFvIExpdSB3cm90ZToKPiA+IFdo
ZW4ga3phbGxvYyBmb3IgcG11c1tpXS5ib3hlcyBmYWlscywgd2Ugc2hvdWxkIGNsZWFuIHVwIHBt
dXMKPiA+IHRvIHByZXZlbnQgbWVtbGVhay4gSG93ZXZlciwgd2hlbiBremFsbG9jIGZvciBhdHRy
X2dyb3VwIGZhaWxzLAo+ID4gcG11cyBoYXMgYmVlbiBhc3NpZ25lZCB0byB0eXBlLT5wbXVzLCBh
bmQgZnJlZWluZyB3aWxsIGJlIGRvbmUKPiA+IGxhdGVyIG9uIGJ5IHRoZSBjYWxsZXJzLiBUaGUg
Y2hhaW4gaXM6IHVuY29yZV90eXBlX2luaXQgLT4KPiA+IHVuY29yZV90eXBlc19pbml0IC0+IHVu
Y29yZV9wY2lfaW5pdCAtPiB1bmNvcmVfdHlwZXNfZXhpdCAtPgo+ID4gdW5jb3JlX3R5cGVfZXhp
dC4gVGhlcmVmb3JlLCBmcmVlaW5nIHBtdXMgaW4gdW5jb3JlX3R5cGVfaW5pdAo+ID4gbWF5IGNh
dXNlIGEgZG91YmxlLWZyZWUuIEZpeCB0aGlzIGJ5IHNldHRpbmcgdHlwZS0+cG11cyB0bwo+ID4g
TlVMTCBhZnRlciBrZnJlZS4KPiAKPiBDaGFuZ2UgaXMgb2sgYnV0IHRoZSBjYWxsIHRyYWNlIHlv
dSB3cm90ZSBoZXJlIGlzIHJldmVyc2VkIG9yIG1hbGZvcm1lZD8/Cj4gV2l0aCB0aGF0IGZpeGVk
IG9yIGNsZWFyZWQuCj4gCgpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLiBJIHdpbGwgZml4IGl0IGFu
ZCByZXNlbmQgYSBuZXcgcGF0Y2ggc29vbi4KClJlZ2FyZHMsCkRpbmdoYW8K
