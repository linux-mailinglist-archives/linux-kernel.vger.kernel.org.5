Return-Path: <linux-kernel+bounces-15061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0B8226CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875071F23A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672BB15B9;
	Wed,  3 Jan 2024 02:15:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27E1846;
	Wed,  3 Jan 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 10:15:16 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 10:15:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: suggestions for capability checks in ldisc_open()
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
Message-ID: <7483af43.c3b3.18ccd1a862a.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowAAHk+k1w5RlFA8DAA--.33811W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAcFE2WUwEQKjgAAss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhIAoKRHVyaW5nIG91ciBjb2RlIHJldmlldywgd2UgbWF5IGhhdmUgb2JzZXJ2ZWQgYW4gaW5h
cHByb3ByaWF0ZSBjYXBhYmlsaXR5IGNoZWNrIGluIHRoZSBsZGlzY19vcGVuKCkgZnVuY3Rpb24u
IEN1cnJlbnRseSwgYm90aCBDQVBfU1lTX0FETUlOIGFuZCBDQVBfU1lTX1RUWV9DT05GSUcgYXJl
IGNoZWNrZWQgYXQgdGhlIGVudHJ5IHBvaW50LiBXZSBwcm9wb3NlIHJlY29uc2lkZXJpbmcgdXNp
bmcgQ0FQX1NZU19UVFlfQ09ORklHIGFsb25lIGZvciB0dHktcmVsYXRlZCBvcGVyYXRpb25zIGFu
ZCBhZGRpbmcgYSBDQVBfTkVUX0FETUlOIGNoZWNrIGZvciBuZXR3b3JrLXJlbGF0ZWQgb3BlcmF0
aW9ucy4gSGVyZSdzIG91ciByYXRpb25hbGUgZm9yIHRoaXMgc3VnZ2VzdGlvbjoKCigxKSBGdW5j
dGlvbmFsaXR5IFVuZGVyIFByb3RlY3Rpb246IFRoZSBwcml2aWxlZ2VkIGZ1bmN0aW9ucyBmb2xs
b3dpbmcgdGhlIGNhcGFiaWxpdHkgY2hlY2tzIHByaW1hcmlseSBpbnZvbHZlIHR0eSBvcGVyYXRp
b25zLCBhbmQgYWNjb3JkaW5nIHRvIHRoZSBjYXBhYmlsaXR5IG1hbnVhbCBwYWdlWzFdLCBDQVBf
U1lTX1RUWV9DT05GSUcgaXMgYSBtb3JlIGZpdHRpbmcgY2FwYWJpbGl0eShDQVBfU1lTX1RUWV9D
T05GSUc6IGVtcGxveSB2YXJpb3VzIHByaXZpbGVnZWQgb3BlcmF0aW9ucyBvbiB2aXJ0dWFsIHRl
cm1pbmFscykuCiAKKDIpIENhdXRpb24gd2l0aCBDQVBfU1lTX0FETUlOOiBEZXZlbG9wZXJzIHRl
bmQgdG8gYXNzdW1lIHRoYXQgQ0FQX1NZU19BRE1JTiBjb250YWlucyBvdGhlciBjYXBhYmlsaXRp
ZXMsIHdoaWNoIG1heSBiZSB0aGUgcmVhc29uIGZvciB0aGUgdHdvIGNhcGFiaWxpdGllcyBleGFt
aW5lZCBoZXJlLiBCdXQgYWNjb3JkaW5nIHRvIGNhcGFiaWxpdHkgbWFudWFsIHBhZ2VbMV0sIOKA
nExpbnV4IGRpdmlkZXMgc3VwZXJ1c2VyIGludG8gZGlzdGluY3QgdW5pdHPigJ0sIGNhcGFiaWxp
dGllcyBzaG91bGQgYmUgaW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlci4gQ0FQX1NZU19BU01JTiBp
cyBhbHJlYWR5IG92ZXJsb2FkZWQgYW5kIGtub3duIGFzIHRoZSBuZXcgInJvb3QiWzJdLCB0aGUg
bWFudWFsIHBhZ2VbMV0gYWxzbyBjbGVhcmx5IHN0YXRlcywg4oCcRG9uJ3QgY2hvb3NlIENBUF9T
WVNfQURNSU4gaWYgeW91IGNhbiBwb3NzaWJseSBhdm9pZCBpdCHigJ0uIFVzaW5nIGEgbW9yZSBz
cGVjaWZpYyBjYXBhYmlsaXR5IGhlbHBzIHRvIGFjaGlldmUgbGVhc3QgcHJpdmlsZWdlLgoKKDMp
IE5ldHdvcmstUmVsYXRlZCBPcGVyYXRpb25zOiBsZGlzY19vcGVuKCkgYWxzbyBlbmdhZ2VzIGlu
IG5ldHdvcmstcmVsYXRlZCBmdW5jdGlvbnMsIHN1Y2ggYXMgYWxsb2NfbmV0ZGV2KCksIG5ldGRl
dl9wcml2KCksIGFuZCByZWdpc3Rlcl9uZXRkZXZpY2UoKS4gSW4gc2ltaWxhciBzY2VuYXJpb3Ms
IHRoZXNlIG5ldHdvcmsgZnVuY3Rpb25zIGFyZSB0eXBpY2FsbHkgcHJvdGVjdGVkIGJ5IENBUF9O
RVRfQURNSU4sIGZvciBleGFtcGxlIGluIG1raXNzX29wZW4oKS4gVGhpcyBjb25zaXN0ZW5jeSBh
Y3Jvc3MgdGhlIGtlcm5lbCBjYW4gaGVscCBtYWludGFpbiBjbGFyaXR5IGFuZCBzdGFuZGFyZGl6
YXRpb24uCgpUaGlzIGlzc3VlIGV4aXN0cyBpbiBzZXZlcmFsIGtlcm5lbCB2ZXJzaW9ucyBhbmQg
d2UgaGF2ZSBjaGVja2VkIGl0IG9uIHRoZSBsYXRlc3Qgc3RhYmxlIHJlbGVhc2UoTGludXggNi42
LjkpLiAKCllvdXIgaW5zaWdodHMgYW5kIGZlZWRiYWNrIG9uIHRoaXMgcHJvcG9zZWQgbW9kaWZp
Y2F0aW9uIHdvdWxkIGJlIGhpZ2hseSB2YWx1YWJsZS4gVGhhbmsgeW91IGZvciB5b3VyIHRpbWUg
YW5kIGNvbnNpZGVyYXRpb24uCgpCZXN0IHJlZ2FyZHMsCkppbmd6aQoKCnJlZmVyZW5jZToKWzFd
IGh0dHBzOi8vd3d3Lm1hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW43L2NhcGFiaWxpdGllcy43
Lmh0bWwKWzJdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy80ODYzMDYv

