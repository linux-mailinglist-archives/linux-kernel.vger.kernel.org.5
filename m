Return-Path: <linux-kernel+bounces-15102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC0822742
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2554284C20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3BD4A26;
	Wed,  3 Jan 2024 02:58:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92333171C4;
	Wed,  3 Jan 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 10:57:33 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 10:57:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Suggestion for Capability Check Adjustment in caif_create()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230921(8ad33efc)
 Copyright (c) 2002-2024 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <987c864.c84f.18ccd413a51.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowAB3QukdzZRlPRUDAA--.26286W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAUFE2WUwEQo-gABs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpEdXJpbmcgb3VyIGNvZGUgcmV2aWV3LCB3ZSBub3RpY2VkIHRoYXQgYm90aCBDQVBfTkVU
X0FETUlOIGFuZCBDQVBfU1lTX0FETUlOIGFyZSBjdXJyZW50bHkgYmVpbmcgY2hlY2tlZCBpbiB0
aGUgY2FpZl9jcmVhdGUoKSBmdW5jdGlvbi4gV2UgcHJvcG9zZSByZXZpc2l0aW5nIHRoZSBjYXBh
YmlsaXR5IGNoZWNrcyBhbmQgY29uc2lkZXJpbmcgYW4gYWRqdXN0bWVudCB0byB1dGlsaXplIENB
UF9ORVRfQURNSU4gZXhjbHVzaXZlbHkuIEhlcmUncyBvdXIgcmVhc29uaW5nIGZvciB0aGlzIHBy
b3Bvc2FsOgoKKDEpIEZ1bmN0aW9uYWxpdHkgb2YgY2FpZl9jcmVhdGUoKTogVGhlIHB1cnBvc2Ug
b2YgY2FpZl9jcmVhdGUoKSBpcyB0byBpbml0aWFsaXplIGEgY2FpZiBzb2NrZXQsIGludm9sdmlu
ZyB0YXNrcyBzdWNoIGFzIGFsbG9jYXRpbmcgYSBzb2NrZXQsIGFzc2lnbmluZyB2YWx1ZXMgdG8g
c3BlY2lmaWMgZmllbGRzLCBldGMuIEdpdmVuIGl0cyByb2xlIGluIG5ldHdvcmtpbmcgb3BlcmF0
aW9ucywgdXNpbmcgQ0FQX05FVF9BRE1JTiBpcyBtb3JlIHByZWNpc2UgYW5kIGFsaWduZWQgd2l0
aCB0aGUgcHJpbmNpcGxlIG9mIGxlYXN0IHByaXZpbGVnZS4KCigyKSBTY29wZSBvZiBDQVBfU1lT
X0FETUlOOiBJbnRyb2R1Y2luZyBhIENBUF9TWVNfQURNSU4gY2hlY2sgY291bGQgcG90ZW50aWFs
bHkgZXhwYW5kIHRoZSBzY29wZSBvZiB0aGUgY2FwYWJpbGl0eS4gQXMgaXQgaXMgYWxyZWFkeSBj
b25zaWRlcmVkIGFzIHRoZSBuZXcgInJvb3QiKGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy80ODYz
MDYvKSwgYW5kIHRoZSBtYW51YWwgcGFnZShodHRwczovL3d3dy5tYW43Lm9yZy9saW51eC9tYW4t
cGFnZXMvbWFuNy9jYXBhYmlsaXRpZXMuNy5odG1sKSBzdGF0ZXMg4oCcRG9uJ3QgY2hvb3NlIENB
UF9TWVNfQURNSU4gaWYgeW91IGNhbiBwb3NzaWJseSBhdm9pZCBpdCHigJ0uIEl0J3MgYmVuZWZp
Y2lhbCB0byB1c2UgdGhlIG1vc3Qgc3BlY2lmaWMgY2FwYWJpbGl0eSByZXF1aXJlZCBmb3IgYSBn
aXZlbiB0YXNrLgoKVGhpcyBpc3N1ZSBleGlzdHMgaW4gc2V2ZXJhbCBrZXJuZWwgdmVyc2lvbnMg
YW5kIHdlIGhhdmUgY2hlY2tlZCBpdCBvbiB0aGUgbGF0ZXN0IHN0YWJsZSByZWxlYXNlKExpbnV4
IDYuNi45KS4KCllvdXIgdGhvdWdodHMgYW5kIGZlZWRiYWNrIG9uIHRoaXMgcHJvcG9zZWQgbW9k
aWZpY2F0aW9uIHdvdWxkIGJlIGhpZ2hseSBhcHByZWNpYXRlZC4gVGhhbmsgeW91IGZvciB5b3Vy
IHRpbWUgYW5kIGNvbnNpZGVyYXRpb24KCkJlc3QgcmVnYXJkcywKSmluZ3ppCg==

