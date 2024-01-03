Return-Path: <linux-kernel+bounces-15045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2918226A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3931F22D18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB7139A;
	Wed,  3 Jan 2024 01:49:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD610EE;
	Wed,  3 Jan 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 09:48:57 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 09:48:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: aacraid@microsemi.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Suggestion for the capability check in aac_send_raw_srb()
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
Message-ID: <363710f0.c0f9.18ccd026bda.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowADXOuoKvZRlxAsDAA--.32448W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAcFE2WUJeXwYgABs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpXZSBub3RpY2VkIGEgcG90ZW50aWFsIHJlZmluZW1lbnQgaW4gdGhlIGFhY19zZW5kX3Jh
d19zcmIoKSBmdW5jdGlvbiwgdGhlIENBUF9TWVNfQURNSU4gaXMgY2hlY2tlZCBhdCB0aGUgYmVn
aW5uaW5nIG9mIHRoZSBmdW5jdGlvbiBhbmQgd2UgYmVsaWV2ZSBpdCBpcyBiZXR0ZXIgdG8gdXNl
IENBUF9TWVNfUkFXSU8gaW5zdGVhZC4gSGVyZSBhcmUgdGhlIHJlYXNvbnMgZm9yIHRoaXMgcmVj
b21tZW5kYXRpb246CgooMSkgUHVycG9zZSBvZiBDYXBhYmlsaXR5IENoZWNrOiBUaGUgZXJyb3Ig
bWVzc2FnZSB3aGVuIENBUF9TWVNfQURNSU4gY2hlY2sgZmFpbHMgaW5kaWNhdGVzIHRoYXQgdGhl
IGNhcGFiaWxpdHkgY2hlY2sgaXMgaW50ZW5kZWQgdG8gcHJvdGVjdCB0aGUgc3Vic2VxdWVudCBz
ZW5kIG9wZXJhdGlvbnMsIGluY2x1ZGluZyBhY2NfaGJhX3NlbmQoKSBhbmQgYWNjX2ZpYl9zZW5k
KCkuIEdpdmVuIHRoYXQgdGhlc2UgZnVuY3Rpb25zIGFyZSB1c2VkIGZvciBzZW5kaW5nIFNDU0kg
Y29tbWFuZHMsIHRoZSBtb3JlIGFwcHJvcHJpYXRlIGNhcGFiaWxpdHksIGFzIHBlciB0aGUgY2Fw
YWJpbGl0eSBtYW51YWwgcGFnZVsxXSwgaXMgQ0FQX1NZU19SQVdJTyAoInBlcmZvcm0gdmFyaW91
cyBTQ1NJIGRldmljZSBjb21tYW5kcyIpLgoKKDIpIENvbnNpc3RlbmN5IHdpdGggQWRkcmVzcyBN
YXBwaW5nOiBUaGUgZnVuY3Rpb24gYWFjX3NlbmRfcmF3X3NyYigpIGFsc28gY2FsbHMgZG1hX21h
cF9zaW5nbGUoKSBmb3IgYWRkcmVzcyBtYXBwaW5nLiBJbiBhIHNpbWlsYXIgY29udGV4dCBpbiBk
cml2ZXJzL3Njc2kvaHBzYS5jLCB0aGUgbWFwcGluZyBmdW5jdGlvbiBpcyBwcm90ZWN0ZWQgYnkg
Q0FQX1NZU19SQVdJTy4gQ29uc2lzdGVuY3kgaW4gdGhlIHVzZSBvZiBjYXBhYmlsaXRpZXMgZW5o
YW5jZXMgY29kZSBjbGFyaXR5IGFuZCBtYWludGFpbnMgYSBzdGFuZGFyZGl6ZWQgYXBwcm9hY2gu
CgooMykgTWFpbnRhaW5pbmcgTGVhc3QgUHJpdmlsZWdlOiBDQVBfU1lTX0FTTUlOIGlzIGFscmVh
ZHkgb3ZlcmxvYWRlZCBhbmQga25vd24gYXMgdGhlIG5ldyAicm9vdCJbMl0sIGFuZCBhY2NvcmRp
bmcgdG8gdGhlIG1hbnVhbCBwYWdlWzFdIOKAnGRvbid0IGNob29zZSBDQVBfU1lTX0FETUlOIGlm
IHlvdSBjYW4gcG9zc2libHkgYXZvaWQgaXTigJ0sICB3ZSBiZWxpZXZlIHRoYXQgdXRpbGl6aW5n
IHRoZSBtb3JlIHNwZWNpZmljIENBUF9TWVNfUkFXSU8gaXMgaW4gbGluZSB3aXRoIHRoZSBwcmlu
Y2lwbGUgb2YgbGVhc3QgcHJpdmlsZWdlIGFuZCBjb250cmlidXRlcyB0byBhIG1vcmUgc2VjdXJl
IGNvZGViYXNlLgoKVGhpcyBpc3N1ZSBleGlzdHMgaW4gc2V2ZXJhbCBrZXJuZWwgdmVyc2lvbnMg
YW5kIHdlIGhhdmUgY2hlY2tlZCBpdCBvbiB0aGUgbGF0ZXN0IHN0YWJsZSByZWxlYXNlKExpbnV4
IDYuNi45KQoKV2Ugd291bGQgYXBwcmVjaWF0ZSB5b3VyIGluc2lnaHRzIGFuZCBmZWVkYmFjayBv
biB0aGlzIHByb3Bvc2FsLiBUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgY29uc2lkZXJhdGlv
bi4KCkJlc3QgcmVnYXJkcywKSmluZ3ppCgpyZWZlcmVuY2U6ClsxXSBodHRwczovL3d3dy5tYW43
Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuNy9jYXBhYmlsaXRpZXMuNy5odG1sClsyXSBodHRwczov
L2x3bi5uZXQvQXJ0aWNsZXMvNDg2MzA2Lw==

