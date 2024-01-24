Return-Path: <linux-kernel+bounces-37560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66283B1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E352B29C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEF131E5F;
	Wed, 24 Jan 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZgi7HRl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B1131E43
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122732; cv=none; b=WIwNvbUoP32Lr9UDWxKEM77qWOLhuYx+OM8F3BfAg09vikbWPS1TAwm0rlKxpgJMml5fgiK6sau8fXb4Kcx1AUC5rIXFoQ9oVaA74TXD6rtW8/o7lLEMs0fTLo4L0b/fjXAckXZ1O0rZKERYaJdGiYFA5ITu2Cdsh/MfN0jwy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122732; c=relaxed/simple;
	bh=ounInQX1OopqHF9P5Jemi1qCSNZiwDnPodYtsMa6jN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PF1pzY3keQcgiTFSqWG/+ETyaPC9bZh2bMYxY+R+39e4rk2v/UXRXvX75KKUtiVV9r/e0wto48HdOZazsG4xQR2TpOXKLZY1q/Mrx+b6nbTvlsPe/1NZSr3S9YHrHXzlvy86TGtVs8y3mytk0OaS2VnqRyWRbBcc0ZHgHU4tN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DZgi7HRl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5+inbcM5m5+QxrTHMiU6DwL2MPsH0wdVrLya+aRCkTM=; b=DZgi7HRlytRnzcaZMWtaFIXtdd
	N2hCVVQvCr8holm6KQcvvkjPAci5mpcNGISTSxF2NJO5XIZdAk4D3NzQAET32ndrWvkxwVcdhrmWp
	lArx/UM8r/TdvGdgppF7yCXZ1/NYTbnbCpLBBC8gvA5MMQRMGDAjxqfsTmIBYdYtNz28ME/QiosgM
	ce61m7k9uY5Nv+plKtUeb6PydlREEiXURyVNJgvmcLLuncLjgLgAxFAWPUBjqzlPDVGRLTV8gSloX
	ag1T3euN2ht3hd49uQpO/8HttfwKRfMq4bwMHSSdOiJbYMA0eH4swbGSRRk1J6xs++6hcIqqK6CoZ
	+5huGq1w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSiST-00000007V0m-1ZqL;
	Wed, 24 Jan 2024 18:58:45 +0000
Date: Wed, 24 Jan 2024 18:58:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: [RFC] Printing numbers in SI units
Message-ID: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was looking at hugetlbfs and it has several snippets of code like
this:

        string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
        pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
                h->max_huge_pages_node[nid], buf, nid, i);

That's not terribly ergonomic, so I wondered if I could do better.
Unfortunately, I decided to do it using the SPECIAL flag which GCC
warns about.  But I've written the code now, so I'm sending it out in
case anybody has a better idea for how to incorporate it.


diff --git a/lib/test_printf.c b/lib/test_printf.c
index 69b6a5e177f2..69af4d24a814 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -178,6 +178,16 @@ test_number(void)
 	 * behaviour.
 	 */
 	test("00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
+
+	/*
+	 * C23 does not define the effect of "alternative form".  Indeed
+	 * I think it actually defines it to be Undefined Behaviour which
+	 * apparently lets the compiler delete your entire source code.
+	 */
+	test("2KiB", "%#d", 2048);
+	test("2MiB", "%#d", 2048 * 1024);
+	test("1GiB", "%#d", 1024 * 1024 * 1024);
+	test("1000MiB", "%#d", 1024 * 1024 * 1000);
 }
 
 static void __init
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275..a702582c598c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -370,6 +370,56 @@ char *put_dec(char *buf, unsigned long long n)
 
 #endif
 
+/*
+ * precision is the number of digits after the decimal place.  we limit
+ * it to two, because more would be complicated and unnecessary.
+ */
+static noinline_for_stack
+char *put_si(char *buf, unsigned long long n, int precision)
+{
+	char *name = "KMGTPEZB";
+	int unit = 0;
+	unsigned remainder = 0;
+
+	if (precision > 2)
+		precision = 2;
+
+	while (n >= 1024) {
+		remainder = n % 1024;
+		n /= 1024;
+		unit++;
+	}
+
+	remainder *= 1000;
+	remainder /= 1024;
+
+	/* Round up */
+	if (precision == 2)
+		remainder += 500;
+	else if (precision == 1)
+		remainder += 50;
+	else
+		remainder += 5;
+	if (remainder >= 1000) {
+		remainder -= 1000;
+		n += 1;
+	}
+
+	*buf++ = 'B';
+	if (unit > 0) {
+		*buf++ = 'i';
+		*buf++ = name[unit - 1];
+	}
+
+	if (precision > 0) {
+		*((u16 *)buf) = decpair[remainder / 10];
+		buf += precision;
+		*buf++ = '.';
+	}
+
+	return put_dec_trunc8(buf, n);
+}
+
 /*
  * Convert passed number to decimal string.
  * Returns the length of string.  On buffer overflow, returns 0.
@@ -507,6 +557,9 @@ char *number(char *buf, char *end, unsigned long long num,
 			tmp[i++] = (hex_asc_upper[((unsigned char)num) & mask] | locase);
 			num >>= shift;
 		} while (num);
+	} else if (spec.flags & SPECIAL) {
+		i = put_si(tmp, num, precision) - tmp;
+		precision = i;
 	} else { /* base 10 */
 		i = put_dec(tmp, num) - tmp;
 	}

