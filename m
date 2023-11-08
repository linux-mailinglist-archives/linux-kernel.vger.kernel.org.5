Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64F7E55C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjKHLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjKHLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:47:54 -0500
Received: from m13103.mail.163.com (m13103.mail.163.com [220.181.13.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F1781711
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=RW/kWeu06y4sBOTbR1FhrflAAtu5wlk7i8tSwn9luUs=; b=I
        bi3ox0Do2/fiXhk94DHANoVYP6iVzA6E+ZZtNhwME40Xr5oc9O5WeGNX1JER3dm2
        r9tt0VdqVnyRNyvb9hZ9hyYuZvSOmS/VvwBxGNHYd3WiLMxYD9iIUKnvXxNxloHS
        o1L1D2DYeukbnuzleCOJPbCvSEF7DeYWHLxjk70YVQ=
Received: from 00107082$163.com ( [111.35.186.243] ) by
 ajax-webmail-wmsvr103 (Coremail) ; Wed, 8 Nov 2023 19:47:10 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Wed, 8 Nov 2023 19:47:10 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [BUG?] mm/secretmem: memory address mapped to memfd_secret can be
 used in write syscall.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuySC/ifu0go5iiZbOkXn0oTju85XMCzuv8j3YJeN500kivj2A4sQlNEIX3s9vutDSqjnDSFTQJO8sp8QbB6eq1cJ1aHoWFDgh/GSpEwro1t
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <61159548.60cf.18baec1fd65.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: Z8GowAD3n3k_dUtlVIEEAA--.23484W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTBgiqmI0cF-87QADs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpLApBY2NvcmRpbmcgdG8gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzg2NTI1Ni8sIAp0aGUg
bWVtb3J5IGFkZHJlc3MgZ290IGZyb20gbWVtZmRfc2VjcmV0L2Z0cnVuY2F0ZS9tbWFwIHNob3Vs
ZCBub3QgYmUgdXNlZCBieSBzeXNjYWxscywgc2luY2UgaXQgaXMgbm90IGFjY2Vzc2libGUgZXZl
biBieSBrZXJuZWwuCgpCdXQgbXkgdGVzdCByZXN1bHQgc2hvd3MgdGhhdCB0aGUgInNlY3JldCIg
bWVtb3J5IGNvdWxkIGJlIHVzZWQgaW4gIHN5c2NhbGwgd3JpdGUsIGlzIHRoaXMgZXhwZWN0ZWQg
YmVoYXZpb3I/ClRoaXMgaXMgbXkgdGVzdCBjb2RlOgoKaW50IG1haW4oKSB7CglpbnQgZmQgPSBz
eXNjYWxsKF9fTlJfbWVtZmRfc2VjcmV0LCAwKTsKCWlmIChmZCA8IDApIHsKCQlwZXJyb3IoIkZh
aWwgdG8gY3JlYXRlIHNlY3JldCIpOwoJCXJldHVybiAtMTsKCX0KCWlmIChmdHJ1bmNhdGUoZmQs
IDEwMjQpIDwgMCkgewoJCXBlcnJvcigiRmFpbCB0byBzaXplIHRoZSBzZWNyZXQiKTsKCQlyZXR1
cm4gLTE7Cgl9CgljaGFyICprZXkgPSBtbWFwKE5VTEwsIDEwMjQsIFBST1RfUkVBRHxQUk9UX1dS
SVRFLCBNQVBfU0hBUkVELCBmZCwgMCk7CglpZiAoa2V5ID09IE1BUF9GQUlMRUQpIHsKCQlwZXJy
b3IoIkZhaWwgdG8gbW1hcCIpOwoJCXJldHVybiAtMTsKCX0KCS8vIHNob3VsZCBiZSBzb21lIHNl
Y3VyZSBjaGFubmVsCglzdHJjcHkoa2V5LCAiVGhpc0lzQUtleSIpOwoJLy8gcHJpbnRmKCJbJWRd
a2V5KCVzKSByZWFkeTogJXBcbiIsIGdldHBpZCgpLCBrZXksIGtleSk7CgkvLyBnZXRjaGFyKCk7
CgkvLyBtYWtlIHN5c2NhbGwsIHNob3VsZCBlcnIKCXdyaXRlKFNURE9VVF9GSUxFTk8sIGtleSwg
c3RybGVuKGtleSkpOyAgLy88LS0gSGVyZSB0aGUga2V5IHNob3dzIHVwIG9uIHN0ZG91dC4KCgly
ZXR1cm4gMDsKfQoKVGhhbmtzCkRhdmlkCgoK
