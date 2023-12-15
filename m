Return-Path: <linux-kernel+bounces-789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F81814607
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74A61F234E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8691CAA4;
	Fri, 15 Dec 2023 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAWMFIsQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWxsUaDG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922C1BDDC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 11:58:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702637914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emw64z31Kkb7/qbx35G2LbmcOdKvaq/JLuZQeZftAZo=;
	b=hAWMFIsQXgUBb6MHtY7bbf81SbgDom1QqlHy9TC+TPT2Qx2sH0YMqehBfFdIRasV1LCN95
	I8eX6+ADOzW0/Ef8xgaHuUZzdhFJuzB+IhKrn0nOuZ49OxQmBA+/KxaNUUma5HFwBXNxE+
	1aAO5u9O2y5A1dj9OD63n5lbES+gR5DVnNc5w0TmmNlm0KDOcfWHVBhFASW8qO9M1lYASw
	9gOVOt7uuIULjGFnCqrcA/EYigeHvVfX+eFzs/Lv63H6QB3Cubu0wpQT9nmD4TXrHaCV/4
	z+9UPPdzjQ+pfWwZjS7dFDX/8q5nRSvTYdgOLICPM3iEotHxB0BAOgUHJ6magw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702637914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emw64z31Kkb7/qbx35G2LbmcOdKvaq/JLuZQeZftAZo=;
	b=VWxsUaDGm8q85XnUB0OHDdVqJSvRQxNTI5omn6FQ1Vltdzvj4UMnR2Ex2dn8Ex/EYAgFCr
	hIFCTV4Wju+skDDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
Message-ID: <20231215105833.aIn3h90O@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <20231215095526.ZA8Q-45e@linutronix.de>
 <8734w3hj2z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734w3hj2z.fsf@jogness.linutronix.de>

On 2023-12-15 11:16:44 [+0106], John Ogness wrote:
> No, it is not a bug at this point. As the commit message writes:
> 
> "Until now this mapping has been correct for all call sites."
> 
> But if the mapping is not changed here, it will become a bug after
> applying patch 3 of this series.

Okay. Thank you clarifying this.

> John

Sebastian

