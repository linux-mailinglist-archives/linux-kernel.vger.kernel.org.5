Return-Path: <linux-kernel+bounces-15158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C98227E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11812B22840
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028BD16406;
	Wed,  3 Jan 2024 05:01:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB52171B4;
	Wed,  3 Jan 2024 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from mengjingzi$iie.ac.cn ( [121.195.114.118] ) by
 ajax-webmail-APP-17 (Coremail) ; Wed, 3 Jan 2024 13:00:58 +0800 (GMT+08:00)
Date: Wed, 3 Jan 2024 13:00:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
To: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de, 
	senozhatsky@chromium.org, keescook@chromium.org, tony.luck@intel.com, 
	gpiccoli@igalia.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Suggestion for Capability Check Refinement in
 check_syslog_permissions()
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
Message-ID: <1ee10aa6.d064.18ccdb23971.Coremail.mengjingzi@iie.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowABHEukK6pRloyADAA--.32165W
X-CM-SenderInfo: pphqwyxlqj6xo6llvhldfou0/1tbiBwcFE2WUvqKB1wABss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGksIHdlIHN1Z2dlc3QgcmV2aXNpdGluZyB0aGUgY2FwYWJpbGl0eSBjaGVja3MgaW4gY2hlY2tf
c3lzbG9nX3Blcm1pc3Npb25zKCkuIEN1cnJlbnRseSBDQVBfU1lTTE9HIGlzIGNoZWNrZWQgZmly
c3QsIGFuZCBpZiBpdOKAmXMgbm90IHRoZXJlIGJ1dCB0aGVyZSBpcyBhIENBUF9TWVNfQURNSU4s
IGl0IGNhbiBhbHNvIHBhc3MgdGhlIGNoZWNrLiBXZSByZWNvbW1lbmQgcmVmaW5pbmcgdGhpcyBj
aGVjayB0byBleGNsdXNpdmVseSB1c2UgQ0FQX1NZU0xPRy4gSGVyZSdzIG91ciByZWFzb25pbmcg
Zm9yIHRoaXMgc3VnZ2VzdGlvbjoKCigxKSBJbmRlcGVuZGVuY2Ugb2YgQ0FQX1NZU0xPRyBhbmQg
Q0FQX1NZU19BRE1JTjogU2luY2UgdGhlIGludHJvZHVjdGlvbiBvZiBDQVBfU1lTTE9HIGluIExp
bnV4IDIuNi4zNywgaXQgaGFzIGJlZW4gYSBkaXN0aW5jdCBjYXBhYmlsaXR5IGZyb20gQ0FQX1NZ
U19BRE1JTi4gRm9yIGNvbXBhdGliaWxpdHkgcmVhc29ucywgaXQgbWlnaHQgbWFrZSBzZW5zZSB0
byBrZWVwIENBUF9TWVNfQURNSU4gYXQgdGhlIGJlZ2lubmluZy4gSG93ZXZlciwgbm93IHRoYXQg
MTMgeWVhcnMgaGF2ZSBwYXNzZWTvvIx3ZSB0aGluayBtYXliZSBpdCdzIGFwcHJvcHJpYXRlIHRv
IHVwZGF0ZSB0aGUgY29kZSB0byByZWZsZWN0IHRoZWlyIHNlcGFyYXRlIHJvbGVzLiAKCigyKSBN
YWludGFpbmluZyBMZWFzdCBQcml2aWxlZ2UgUHJpbmNpcGxlOiBDQVBfU1lTX0FETUlOIGlzIG92
ZXJsb2FkZWQgYW5kIGtub3duIGFzIHRoZSBuZXcgInJvb3QiWzFdLiBBbmQgYWNjb3JkaW5nIHRv
IHRoZSBtYW51YWwgcGFnZVsyXSDigJxEb24ndCBjaG9vc2UgQ0FQX1NZU19BRE1JTiBpZiB5b3Ug
Y2FuIHBvc3NpYmx5IGF2b2lkIGl0IeKAnSwgaXQncyBiZW5lZmljaWFsIHRvIHVzZSB0aGUgbW9z
dCBzcGVjaWZpYyBjYXBhYmlsaXR5IHJlcXVpcmVkIGZvciBhIGdpdmVuIHRhc2suCgpUaGlzIGlz
c3VlIGV4aXN0cyBpbiBzZXZlcmFsIGtlcm5lbCB2ZXJzaW9ucyBhbmQgd2UgaGF2ZSBjaGVja2Vk
IGl0IG9uIHRoZSBsYXRlc3Qgc3RhYmxlIHJlbGVhc2UoTGludXggNi42LjkpLiAKCllvdXIgZmVl
ZGJhY2sgYW5kIGluc2lnaHRzIG9uIHRoaXMgcHJvcG9zZWQgbW9kaWZpY2F0aW9uIHdvdWxkIGJl
IGhpZ2hseSBhcHByZWNpYXRlZC4gVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIGNvbnNpZGVy
YXRpb24uCgpCZXN0IHJlZ2FyZHMsCkppbmd6aQoKcmVmZXJlbmNlOgpbMV0gaHR0cHM6Ly9sd24u
bmV0L0FydGljbGVzLzQ4NjMwNi8KWzJdIGh0dHBzOi8vd3d3Lm1hbjcub3JnL2xpbnV4L21hbi1w
YWdlcy9tYW43L2NhcGFiaWxpdGllcy43Lmh0bWw=

