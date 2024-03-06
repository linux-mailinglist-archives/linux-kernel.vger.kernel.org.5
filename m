Return-Path: <linux-kernel+bounces-93446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5A872FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44091C21BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBD5CDD5;
	Wed,  6 Mar 2024 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NQJpD9v6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NQJpD9v6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A017742
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711387; cv=none; b=nq6KCEVHIfdx2wuCFBIz9J6H+gZMw6IMWaddYfHYX3oEClZBWcaiFRvg0jzrsZc0HRfGmmPFavwFk7PLJWlg/2mE/Js9xmdlub/5LG6EzhZ1fsU5EsVJ9gDtX2thmmMDQidJu4lzQef4MAB9fEGjukJPvcU75U3MszqSnebOpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711387; c=relaxed/simple;
	bh=AviOqzGfhRCEHBBicCf3rWVk3gZM7cG6dgxWNp04GfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJCgC6uDJ7qx/DGKrNUNhxq1IvrQffgZQ59Isxb+NApjSrh0SGuOCNYEJCC9tT58KripNmgFBcgHq1FO5poMhYQlhCCOeBRCxBKawgMry1n/9yiHnw7sYcYelHLFMj5+vdVfkRGjfeFtGhPIuM4N+ZU1MWmQIMwn7vbaF4i4QWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NQJpD9v6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NQJpD9v6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 712076724E;
	Wed,  6 Mar 2024 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709711383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9fZ7OjuDVro7vHBEqtW78g1fAw1hYAPr1QHozAFJVk=;
	b=NQJpD9v6ujHrHpjacrJCPdQrSVYoEF2z5bnJGoxWQ/ggf5qFd+Fo0/AUu3/LtRrzuZjTMb
	HGTyENpWfUvRPwYPB0Cl4Ajza6fZ1AnOpnqnPfUwFsaZZDMXsA9PLGIH3IaUtah+kfnQw2
	fnFmN67MO+d067YVzrq608caXQpfFBM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709711383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9fZ7OjuDVro7vHBEqtW78g1fAw1hYAPr1QHozAFJVk=;
	b=NQJpD9v6ujHrHpjacrJCPdQrSVYoEF2z5bnJGoxWQ/ggf5qFd+Fo0/AUu3/LtRrzuZjTMb
	HGTyENpWfUvRPwYPB0Cl4Ajza6fZ1AnOpnqnPfUwFsaZZDMXsA9PLGIH3IaUtah+kfnQw2
	fnFmN67MO+d067YVzrq608caXQpfFBM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5762813A9C;
	Wed,  6 Mar 2024 07:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NiAtExcg6GXEXwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 06 Mar 2024 07:49:43 +0000
Date: Wed, 6 Mar 2024 08:49:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52560: mm/damon/vaddr-test: fix memory leak in
 damon_do_test_apply_three_regions()
Message-ID: <ZeggFvhW-nLqM6G-@tiehlicka>
References: <2024030252-CVE-2023-52560-c3de@gregkh>
 <ZedNf9uP3_TjIy0g@tiehlicka>
 <2024030527-sinless-platter-510a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030527-sinless-platter-510a@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NQJpD9v6
X-Spamd-Result: default: False [-5.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.37)[97.08%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 712076724E
X-Spam-Level: 
X-Spam-Score: -5.68
X-Spam-Flag: NO

On Tue 05-03-24 22:25:11, Greg KH wrote:
> On Tue, Mar 05, 2024 at 05:51:11PM +0100, Michal Hocko wrote:
> > On Sat 02-03-24 22:59:54, Greg KH wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
> > > 
> > > When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> > > and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> > 
> > This is a kunit test case AFAICS. Is this really a CVE material?
> 
> People run kunit tests on real systems (again, we do not dictate use
> cases.)  So yes, fixing a memory leak that can be triggered is resolving
> a weakness and so should get a CVE I would think, right?

This is stretching the meaning of CVE beyond my imagination. Up to you
to decide but I yet have to see a real production system that casually
runs unit test just for <looking for a reason .... but failed>.
-- 
Michal Hocko
SUSE Labs

