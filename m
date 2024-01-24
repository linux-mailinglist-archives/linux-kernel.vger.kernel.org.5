Return-Path: <linux-kernel+bounces-37681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849883B393
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0CF1C22808
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC91350F0;
	Wed, 24 Jan 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bhlaR2Yf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IW/ecCj4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bhlaR2Yf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IW/ecCj4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C313473C;
	Wed, 24 Jan 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130465; cv=none; b=CDFriMddATtE2zgzjHEzqtnE0750y8ChJ64G6+WuGXrsGuLgA+3wT30DVhlJAVUTNVNjKyHvoSFgI4476cONAuHuDrGu9PRPO56oMXuiXmAk1feoVIGwIoMcyq27UKS1opTmFwteBbvsX72TGls99LDy1bwL3iLpKkkOs6GmjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130465; c=relaxed/simple;
	bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTztQjMhOIYUiMNUfERT7ya3q7adQN0Sxalkz74UsOM9agxXmQsnOBRXvxFbVa1oLr158ZMX2jwqTXuvRS6Z6F//2l5QCinKUG4Kr24XpU6dvo6y/5v7DKMk2ryuNnc3ZIK52Z0LRcl+xWSoYVzAaY2zDUQNz7rPLbdkLdNre6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bhlaR2Yf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IW/ecCj4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bhlaR2Yf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IW/ecCj4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 774101FD85;
	Wed, 24 Jan 2024 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706130460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
	b=bhlaR2YfxB7uY2qDCArefuiHcH7mMFEfJlnP32LbHYgZ5HNmR0xr14LsJSeVq9fsi2Naoz
	7gAkO2Zrp95ev5eXzFbUECiLW/QnPiJH6+P1B0mZIge7f5kP2M2YaPd6jt7JOzthXnex0H
	BqPUa+zxlbqn2t0ZDp0OqaCTtg2Uwks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706130460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
	b=IW/ecCj47EDOsBR5afQ28U83EFPkaC9NbkePVxVBnRGgxpZZXuDT3j2fly/bqBx3hf4wno
	xUYBfSWWxl3edTBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706130460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
	b=bhlaR2YfxB7uY2qDCArefuiHcH7mMFEfJlnP32LbHYgZ5HNmR0xr14LsJSeVq9fsi2Naoz
	7gAkO2Zrp95ev5eXzFbUECiLW/QnPiJH6+P1B0mZIge7f5kP2M2YaPd6jt7JOzthXnex0H
	BqPUa+zxlbqn2t0ZDp0OqaCTtg2Uwks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706130460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJlN+UTDIEQ6+eaqc7+8C81gK2cUGa2ixRad25rlMX0=;
	b=IW/ecCj47EDOsBR5afQ28U83EFPkaC9NbkePVxVBnRGgxpZZXuDT3j2fly/bqBx3hf4wno
	xUYBfSWWxl3edTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E0F13786;
	Wed, 24 Jan 2024 21:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQSyORt8sWXZdAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 21:07:39 +0000
Date: Wed, 24 Jan 2024 22:07:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: bcachefs fails to mount loop device on kernel
Message-ID: <20240124210738.GA352616@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240124200032.GA343522@pevik>
 <20240124205149.GA268968@fedora-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124205149.GA268968@fedora-laptop>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.08
X-Spamd-Result: default: False [-1.08 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.58)[81.45%]
X-Spam-Flag: NO

> On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> > Hi all,

> > bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> > Is mounting loop even supported?

> > [...]

> > bcachefs mount /dev/loop0 /mnt
> > => Unknown command mount

> What version of the bcachefs CLI tool are you using? Is it distribution
> provided or did you build it yourself?

Official openSUSE Tumbleweed package:

$ rpm -qf $(which bcachefs)
bcachefs-tools-1.4.0-1.1.x86_64

BTW this was found with LTP, which has 2 APIs: C API, which uses mount(2)
which works well and shell API which uses mount (which uses bcachefs) and here
it fails.

Kind regards,
Petr

> The mount command has been implemented in Rust for a while (since
> 28f703cc256f "Rust now integrated into bcachefs binary") and if building
> without Rust support (BCACHEFS_NO_RUST defined), that command won't be
> included in the binary.

> In more recent versions of bcachefs-tools, building without Rust is not
> supported at all.

> I don't think this has anything to do with loop devices specifically.

> - Thomas Bertschinger

