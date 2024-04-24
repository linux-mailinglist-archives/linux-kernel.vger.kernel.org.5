Return-Path: <linux-kernel+bounces-157737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1B8B1533
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F46EB22D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA6156F2D;
	Wed, 24 Apr 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="OezVXx3Y"
Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716C13C9DE;
	Wed, 24 Apr 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994285; cv=none; b=AacgdOZiZeu19DxfJbWbzu5VkxNtCVB/Q9PGWlC1+VjW67hpnvreNINiDbt1cof4Hrnfmn/Zhi5ttvscnTDssSgzV0k78D1znssIDp64TbRvzY7Sz6EyHZrL1Q/zXhdUOsBgPquUvXy3rb4EFckb+Fo3gQSswvnz7aOPHfNyYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994285; c=relaxed/simple;
	bh=QQYEnBmWJr1g+ELcn8hSNT35DEr8cmUpviFzxPLvmT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MFEJ7f/SS47O4PB+bOv83jBJ9K30vrJFLOn9Nd+HDuIeq9VK9bDcNBiX6aShhOe6QxzapVqu+VXoqJpbBXxawALPfqATjjShc8RUFGyaJQx791HASVkHJQvjvOalON1pPMPKFIePThLhhPjZozwzOXBeFZa2JemKtvE3eYPGFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=OezVXx3Y; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 43OLVGWb636929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 17:31:17 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4VPscN4ZlWzgd52Y;
	Wed, 24 Apr 2024 17:31:16 -0400 (EDT)
Date: Wed, 24 Apr 2024 17:31:14 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
 <jirislaby@kernel.org>
Subject: N_HDLC line discipline: Race condition
Message-ID: <20240424173114.035ddd7b@gato.skoll.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/+i1Aaa_lVkITwC_AIx1F5nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:mime-version:content-type; s=
	canit2; bh=jr0e+TcL/8llOHDMICBg3cEEx5gL/J6qoyzPalX/RT4=; b=OezVX
	x3YDElOPnIIVVJil04TX9lenmnNIuR33u+TsvxHyW/b6mz8s7X97GVsMHGozM5Fa
	IEsaVmFti3RyF6gGdPndlwcFqy+t9jhyfkmDTB95Y1wLolnsAjCefiIUKnW6dkyi
	V0LFjGwiETG5ffXdDKNq2IGxwlu5T6xAml1ZQIzbYnuvkCgPpUrngNXr7KUaL9YY
	uGjEYGkfn+KAS/h16fkFKEJF0t+sMnpBtx1ryFoGFEm28bHkDg43xYlpsLgdJ2D2
	QhAX71omuLTVXXIJ4Kew+ivYXKwpvXPwy5fxOJjpOBLHdYiTjRsLKyW5mDlUG/oT
	L68nKE1+h80RSrUDw==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.16 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20240424 / 01cf9vh1g

--MP_/+i1Aaa_lVkITwC_AIx1F5nM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm reposting here (originally emailed GregKH and Jiri Slaby directly
as they are listed as tty maintainers) as well as responding to a
reply from Greg.

Original mail:

Some people have been reporting bugs using synchronous PPP with the
rp-pppoe user-space program.  See for example
https://github.com/dfskoll/rp-pppoe/issues/32

I've narrowed this down to the N_HDLC line discipline sometimes
concatenating two packets on the write side into a single read on the
other side.  I have attached a proof-of-concept program illustrating
the problem.

If you run:

/test_n_hdlc

with no arguments, then the program makes two writes in quick succession
to the tty followed by a read.  It generally only takes one or two tries
on my computer before I see both writes being combined in a single read.

On the other hand, if you run:

/test_n_hdlc foo

with a single argument, then the program sleeps for 0.1s between writes,
and I never see them being combined in a single read, even after 20 tries.

I'm running mainline kernel 6.8.7 on amd64; the processor model name
per cpuinfo is: AMD Ryzen Threadripper 3970X 32-Core Processor

Regards,

Dianne.

Greg's reply with my responses inline:

> What is wrong with that?  Does the N_HDLC line discipline somewhere
> state that this is not possible to happen?  Normal write combining
> happens for other tty ldiscs.  Userspace should be able to handle
> this, unless again, the N_HDLC ldisc somehow says that this should
> never happen.

> Ok, I looked at the comments at the top of the the ldisc, and it says
> this should not happen, so something is odd, I agree.

Right.  It's done that way so a PPP 'pty' helper always gets exactly one
frame when it reads from the tty file dscriptor.

> Did this change recently?  Or has this always been the case?  Meaning
> did something in the kernel change to cause this to break?

I haven't used this mode of PPP in over a decade, so I know it used to work,
but no longer does.  I'm sorry I can't narrow down more precisely as to
when it stopped working.

> Also, please cc: the linux-serial list for tty issues, doing stuff in
> private is generally not a good idea.

OK, sorry about that... I misread the bug reporting instructions and
forgot to Cc the lists.

Regards,

Dianne.

--MP_/+i1Aaa_lVkITwC_AIx1F5nM
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=test_n_hdlc.tar.gz

H4sICCpqKWYCA3Rlc3Rfbl9oZGxjLnRhcgDtV/tv2zYQ9q/TX3FJ4EB2PUfyK0PcFGidACmW2UPi
Yhu6QpAlKhEiU4ZIxw0W92/vkXpRymMDhgQowA+ILfLuPt7xHnI4YdyhzrUfeQeNF4KFOBwOxbd9
OLTU7xwNezCye73R0OqPGpaNq34Dho1XwJpxNwFo+AF7Vu/f5D8ouJL/39wbEoQReYn8jwaDJ/Nv
230l/6hn97ECGmDp/L843Cg6AqUIDENZVCRdlHkRcemR8VOyhJ8DVQjtb0ZD48fu/0qyX6//B31r
mPf/4HCA7wl7YPeGuv9fA3s+jnxKwPlz9vvp1LmcfbqYnMLIsoy9kHrR2ifwlnE/jLvX76pbUbio
7gUe5VF1a8XvqhtrGqJpnSsJ6VV1j4dLInaM3L/5xcfTS+hZhnEbh77hx84mCTkxQ8oh8DvgXWMW
vZgyDm0kbBn/GIAQ4gSOIVUWiiiUHxGhplBsjaXiCn3ggbmbKjZRscnwz2+hcdP/m+52oLAWh7ZU
jg4kSLM1DBQI1xLi+plnuSPSv8U6+NyzBr98GVeck+qCHeUdEAo1p6RCs6JQdSvJDMIAzATegdWC
9FiVBY3R6r7ZbbN7aZlIwsx0Kz8TwtcJhURGI2+aRYSsbMtaMjOPBUNeexxEjtiKeCBVxGpsSPlB
G05I5N5BECdgdW1gBDPjM2gfpPa5fpffOihDr6zxQwlNRXbxIxEOcJGdQV0aS21zvzDqwPTT+XmR
CVi6IZVpcJMrLyuRdhsXt5+/VAqkTEdYPi4Dv1wE8Zr6pZ9qta04K/WYauSHTAQwdc5Ozifj/3R1
eCharGIWfnXiFaErbs6ci5M/Lu5nznQ2mc//qpWGqlrWBNK0MkZRYFeJSzlSpduqeS4RhV4xT2uq
YFjTKPZuHqUoRJVmqVLgHYmwOKPukjzCkUsyClZSoCQnYfJuRKgm7nagdjHyYfrhfDb5tcYuTZpM
8U7as+olhbHHI1MeOv84m1yezk86sC9yWKNLFZuKXuu5q0vV2f/kZRVe7LB5cgfrFfA4G42ypGTH
8WuSzjsmpAuChbpc4Az1sSjBBYbDNiJy6OQNKazM8NgeQ/j2WNLh05s36hApBq4McPeMRFEMu1kE
+egRfYbTx1YN1QgvRbXj8fJAOVPQPb4hhGYOY6gKZTERsvFTSrZP+bWJk8hXOR639+OahyJR+eBm
RXmqsaEGzqIHoanhnb0/e78DMjN7Tf8I5pgIvonzZGxI8kwudmSaw9rJaXbS2WNXReUdbGFzjf+2
ZaMf9vdhR9rUspPu1fxf4Nk39YvdGsXbZOeBVRHtctkBN+AkwRoFfIcT7ClKbnHN3I2sQiX4J+Pu
yrhl0VXeRF4UM6LkIl2Xo4N8DblppcNe/4zX0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQqOA7Z7kBcwAo
AAA=

--MP_/+i1Aaa_lVkITwC_AIx1F5nM--

