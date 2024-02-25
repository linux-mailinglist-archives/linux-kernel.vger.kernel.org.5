Return-Path: <linux-kernel+bounces-80217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B187862BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D23281AFF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298851802E;
	Sun, 25 Feb 2024 16:53:47 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771017BDC
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880026; cv=none; b=EdTmzlKCJBVw8JnohLD2NCRG/a9TgwUiKE3D4kil3qQU2GCq6SRgp9XlcgOCIvrN+59HiegFd/QeTyip+KqWp87OvuLT/la50d9I9xlPomRCS/6dEUJRamgHCvQFWdsB7Q1STU58S5lXuTtYN4Up3WVW6s4ZVP1XPaSgV19c4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880026; c=relaxed/simple;
	bh=yzk8hJGS5EAJboFzprtLjoWXpcFk7Mo9VpW2lpjOHHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tbhcj8o6+VU53Xnupdx8JdVDr2+BDlpbNQ0DaxZoTmuCnM9PL7edSV7H+7DCC/OWri6ORCh1htHEoGvuIwFhhslbVKVMns0BWCEETh5zYFPN1xIRQaMkj9/Q5YSJm+uR9IJHnMg6QIgZr0uYZaONmPdRFnMZ9w5dLeCE0t7+kNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-E8tAd1F8OPi8n5OgxZplNA-1; Sun, 25 Feb 2024 16:53:41 +0000
X-MC-Unique: E8tAd1F8OPi8n5OgxZplNA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:53:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:53:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, 'Netdev'
	<netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
	<dri-devel@lists.freedesktop.org>
CC: 'Jens Axboe' <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, "'Andrew
 Morton'" <akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
	<davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>, "'Jani
 Nikula'" <jani.nikula@linux.intel.com>
Subject: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
Thread-Topic: [PATCH next v2 08/11] minmax: Add min_const() and max_const()
Thread-Index: AdpoCy246SYrYUdtTu+AtQRSWe90RA==
Date: Sun, 25 Feb 2024 16:53:40 +0000
Message-ID: <c6924533f157497b836bff24073934a6@AcuMS.aculab.com>
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
In-Reply-To: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The expansions of min() and max() contain statement expressions so are
not valid for static intialisers.
min_const() and max_const() are expressions so can be used for static
initialisers.
The arguments are checked for being constant and for negative signed
values being converted to large unsigned values.

Using these to size on-stack arrays lets min/max be simplified.
Zero is added before the compare to convert enum values to integers
avoinding the need for casts when enums have been used for constants.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 278a390b8a4c..c08916588425 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -60,19 +60,34 @@
 =09=09=09#op "(" #x ", " #y ") signedness error, fix types or consider u" =
#op "() before " #op "_t()"); \
 =09=09__cmp_once(op, x, y, uniq); }))
=20
+#define __careful_cmp_const(op, x, y)=09=09=09=09\
+=09(BUILD_BUG_ON_ZERO(!__is_constexpr((x) - (y))) +=09\
+=09=09BUILD_BUG_ON_ZERO(!__types_ok(x, y)) +=09=09\
+=09=09__cmp(op, (x) + 0, (y) + 0))
+
 /**
  * min - return minimum of two values of the same or compatible types
  * @x: first value
  * @y: second value
+ *
+ * If @x and @y are constants the return value is constant, but not 'const=
ant
+ * enough' for things like static initialisers.
+ * min_const(@x, @y) is a constant expression for constant inputs.
  */
 #define min(x, y)=09__careful_cmp(min, x, y, __COUNTER__)
+#define min_const(x, y)=09__careful_cmp_const(min, x, y)
=20
 /**
  * max - return maximum of two values of the same or compatible types
  * @x: first value
  * @y: second value
+ *
+ * If @x and @y are constants the return value is constant, but not 'const=
ant
+ * enough' for things like static initialisers.
+ * max_const(@x, @y) is a constant expression for constant inputs.
  */
 #define max(x, y)=09__careful_cmp(max, x, y, __COUNTER__)
+#define max_const(x, y)=09__careful_cmp_const(max, x, y)
=20
 /**
  * umin - return minimum of two non-negative values
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


