Return-Path: <linux-kernel+bounces-15134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916BB82278F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35305B21BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857910A15;
	Wed,  3 Jan 2024 03:24:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD394A26;
	Wed,  3 Jan 2024 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 11:24:19 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 11:24:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Suggestion for Capability Check Refinement in too_many_unix_fds()
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
Message-ID: <490cec47.ca8f.18ccd59bda2.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowABHEulk05RlfhgDAA--.31854W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiDAcFE2WUwEQ9hAABsQ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkhCgpXZSBpZGVudGlmaWVkIGEgcG90ZW50aWFsIHJlZmluZW1lbnQgaW4gdGhlIHRvb19tYW55
X3VuaXhfZmRzKCkgZnVuY3Rpb24uIEN1cnJlbnRseSBDQVBfU1lTX0FETUlOIGFuZCBDQVBfU1lT
X1JFU09VUkNFIGFyZSBjaGVja2VkIHdoZW4gdGhlIG51bWJlciBvZiBvcGVuIGZpbGVzIGluIGEg
c29ja2V0IGV4Y2VlZHMgdGhlIHVwcGVyIGxpbWl0LCBoYXZpbmcgZWl0aGVyIG9uZSBjb3VsZCBw
YXNzIHRoZSBjaGVjay4gV2UgcmVjb21tZW5kIHJldmlzaXRpbmcgdGhlIGNhcGFiaWxpdHkgY2hl
Y2tzIGFuZCBjb25zaWRlcmluZyB0byB1dGlsaXplIENBUF9TWVNfUkVTT1VSQ0UgZXhjbHVzaXZl
bHkuIEhlcmUncyBvdXIgcmF0aW9uYWxlIGZvciB0aGlzIHN1Z2dlc3Rpb246CgooMSkgRGVmaW5l
ZCBDYXBhYmlsaXR5IGZvciBSZXNvdXJjZSBMaW1pdHM6IEFjY29yZGluZyB0byB0aGUgY2FwYWJp
bGl0eSBtYW51YWwgcGFnZVsxXSwgdGhlIGNhcGFiaWxpdHkgZXhwbGljaXRseSBkZXNpZ25lZCBm
b3IgYnlwYXNzaW5nIHN5c3RlbSByZXNvdXJjZSBsaW1pdHMgaXMgQ0FQX1NZU19SRVNPVVJDRShD
QVBfU1lTX1JFU09VUkNFOiBhbGxvdyB0aGUgUkxJTUlUX05PRklMRSByZXNvdXJjZSBsaW1pdCBv
biB0aGUgbnVtYmVyIG9mICJpbi1mbGlnaHQiIGZpbGUgZGVzY3JpcHRvcnMgdG8gYmUgYnlwYXNz
ZWQpLgoKKDIpIFByZXNlcnZpbmcgTGVhc3QgUHJpdmlsZWdlIFByaW5jaXBsZTogQ0FQX1NZU19B
RE1JTiBjaGVjayBpbiB0aGlzIGNvbnRleHQgbWF5IGxlYWQgdG8gb3Zlci1wcml2aWxlZ2luZy4g
SXQgaXMgYWxyZWFkeSBvdmVybG9hZGVkIGFuZCBrbm93biBhcyB0aGUgbmV3ICJyb290IlsyXS4g
QWNjb3JkaW5nIHRvIHRoZSBtYW51YWwgcGFnZVsxXSDigJxEb24ndCBjaG9vc2UgQ0FQX1NZU19B
RE1JTiBpZiB5b3UgY2FuIHBvc3NpYmx5IGF2b2lkIGl0IeKAnSwgaXQncyBiZW5lZmljaWFsIHRv
IHVzZSB0aGUgbW9zdCBzcGVjaWZpYyBjYXBhYmlsaXR5IHJlcXVpcmVkIGZvciBhIGdpdmVuIHRh
c2suCgpUaGlzIGlzc3VlIGV4aXN0cyBpbiBzZXZlcmFsIGtlcm5lbCB2ZXJzaW9ucyBhbmQgd2Ug
aGF2ZSBjaGVja2VkIGl0IG9uIHRoZSBsYXRlc3Qgc3RhYmxlIHJlbGVhc2UoTGludXggNi42Ljkp
LiAKCllvdXIgZmVlZGJhY2sgYW5kIGluc2lnaHRzIG9uIHRoaXMgcHJvcG9zZWQgbW9kaWZpY2F0
aW9uIHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuIFRoYW5rIHlvdSBmb3IgeW91ciB0aW1l
IGFuZCBjb25zaWRlcmF0aW9uLgoKQmVzdCByZWdhcmRzLApKaW5nemkKCnJlZmVyZW5jZToKWzFd
IGh0dHBzOi8vd3d3Lm1hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW43L2NhcGFiaWxpdGllcy43
Lmh0bWwKWzJdIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy80ODYzMDYv

