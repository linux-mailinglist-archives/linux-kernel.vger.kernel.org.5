Return-Path: <linux-kernel+bounces-27956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775C82F84D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4985C1C24DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905701306FA;
	Tue, 16 Jan 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="ZfsqGwuv"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515A1306E6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434680; cv=none; b=Tj0jLXowKLteUyYa6RdU/abcoPveOu3n7Rw+h/fCuZyyxhnxnz/ItdXybiRvSK/wMSIq8zot+65hpkn7WMHOtnzsYXRCCyQ5G5Cg4/wXG3g7S5TxILIrS3RGeFWC5KAt+mMklVpXZJxQSJdK+jWfoFhrVO2kBC+QGmXq3ekXWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434680; c=relaxed/simple;
	bh=lNLjE5Ct7TCX3VAQR/bkBi7r9pQaHxxrXyczWfCNM7Y=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Bpl; b=R2djpDnV/6aAupATRovkI/ltkInflfRHRIkNAuASeFeZwFEz6kbEtJjSuBadNwJ5ee77nOkTVmatAmHimrmlvHv2tycjlc4+I7RrrPxPHJtzUvEhyMV5+uDk8AeotzvnxFmj37pJcIhiAkdH9B9bGt7Qm/CFL7dUiv9dG0/IfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=ZfsqGwuv; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1705434679;
	bh=lNLjE5Ct7TCX3VAQR/bkBi7r9pQaHxxrXyczWfCNM7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZfsqGwuvVjnK8KqRP4LmOWxvqY1WapyfrSzb3jpOuw66Ru21jLQz0aJnGRPwMYCp2
	 yuF1K/j406IXlrs85snlFEoYwSnhHGXQFLe5wnGV6/jHIi3UZXlffkpbjOQKjBHnvz
	 +UTufLL0z0mXnGcP64GVZLWfxl7WQlnOcVL5kk+9Z1rxGSaCX7Py7Q36+vHKdy7Omn
	 2HstzeDQAAKO4kJgUxne/hnbnPzofdKRKHtgpDP4+Hihn48G83k6WdNdICizvhljn6
	 UN7T1YT40EBLlx+6+7WK/bZH/5oy/qAkOE4gbeWZ1L4s5z/VtoDYTb+K1r1NE/2pux
	 5nE0faM2N1l3w==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.189])
	by gnuweeb.org (Postfix) with ESMTPSA id 6E97C24C3A2;
	Wed, 17 Jan 2024 02:51:17 +0700 (WIB)
Date: Wed, 17 Jan 2024 02:51:13 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Charles Mirabile <cmirabil@redhat.com>, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <ZabeMQs8NEnvgUS2@biznet-home.integral.gnuweeb.org>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
 <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
 <ZabRwdcgU/H8i5Ja@1wt.eu>
 <ZabSG4R45sC0s23d@1wt.eu>
 <ZabUyZG3C3LUax6f@biznet-home.integral.gnuweeb.org>
 <ZabXyRMECEnMUizk@biznet-home.integral.gnuweeb.org>
 <20240116194655.GA5511@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116194655.GA5511@1wt.eu>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Tue, Jan 16, 2024 at 08:46:55PM +0100, Willy Tarreau wrote:
> Yeah I agree, thanks for checking.

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

-- 
Ammar Faizi


