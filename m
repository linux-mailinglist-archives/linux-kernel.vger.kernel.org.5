Return-Path: <linux-kernel+bounces-80991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5CB866EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69363286915
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F7369D02;
	Mon, 26 Feb 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm0ecaSr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B969D06
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937873; cv=none; b=tGs5DeDOIyJmRYZxvfJeDoAiRmf51+ByvjqL+dKh39abYLnVDHfCt4Kyv2lsNohilnGIH8uz3V1iLSccjqT+QpCQj6S9NYlIztDXlaW+/YDR+do7tbXeUb3+sOsHYd305y0kWbU+LvQ6GE8PkwBFxUEZzowAwmj87YgocnOnRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937873; c=relaxed/simple;
	bh=sh71VdSvALbb1x72VML15YUfIUFsFmJ85m1Hgf7DKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUqfvz4XdjEcsR7i6xSIeLmCzJ12Cki/fD2GBFPE8fYoiCFJ/h5Oe7StqTp2Al/A7TL73jxVJH+K3KQ7IqVU3ohxEr9Re7qPjiLi1z+fEJvgJ4ckLiQC6Dx0gUABlgpwB0KbFjPiyDQ2xZYZETm871+PunX3Qy9fRk5LpdUZjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm0ecaSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA702C433C7;
	Mon, 26 Feb 2024 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708937872;
	bh=sh71VdSvALbb1x72VML15YUfIUFsFmJ85m1Hgf7DKVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fm0ecaSrsJB0TogIIJqRWm8n02V8ypWw/tOl2WUYacuDBBP9J2yiz80EhDM1UVzxN
	 j1C6bZarCvwVcWUk0mh0YgMdHJ1EKToc1Iam2RLsCYCmdQOPitPgRknYG8WGBaCNCF
	 swCVL5gTdED2x/0/CT2Anq2XljKwbuM03U8Ayen4vHEVjY88HxH0igN5ukDx4S0tcD
	 zxxPGnnWgbbW/bugIWm8Wnz5jVSXfuEdePG2T9LD+H+m4Gvz03kHrS3FbvuCwabor4
	 pRk7HALf9B5Zg4IWh8mN8WrImcR24oDPDHn+PkvSk6+cX5rjQEyI8xkHTt9CCBb8eN
	 sHMkHJbzFA3Ig==
Date: Mon, 26 Feb 2024 09:57:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	stgraber@stgraber.org, cyphar@cyphar.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Message-ID: <20240226-gestrafft-pastinaken-94ff0e993a51@brauner>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza>
 <20240223-kantholz-knallen-558beba46c62@brauner>
 <ZdoEavHorDs3IlF5@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdoEavHorDs3IlF5@tycho.pizza>

> > > A small quibble, but I wonder about the semantics here. "You can write
> > > whatever you want to this file, but we'll ignore it sometimes" seems
> > > weird to me. What if someone (CRIU) wants to spawn a pid numbered 450
> > > in this case? I suppose they read pid_max first, they'll be able to
> > > tell it's impossible and can exit(1), but returning E2BIG from write()
> > > might be more useful.
> > 
> > That's a good idea. But it's a bit tricky. The straightforward thing is
> > to walk upwards through all ancestor pid namespaces and use the lowest
> > pid_max value as the upper bound for the current pid namespace. This
> > will guarantee that you get an error when you try to write a value that
> > you would't be able to create. The same logic should probably apply to
> > ns_last_pid as well.
> > 
> > However, that still leaves cases where the current pid namespace writes
> > a pid_max limit that is allowed (IOW, all ancestor pid namespaces are
> > above that limit.). But then immediately afterwards an ancestor pid
> > namespace lowers the pid_max limit. So you can always end up in a
> > scenario like this.
> 
> I wonder if we can push edits down too? Or an render .effective file, like

I don't think that works in the current design? The pid_max value is per
struct pid_namespace. And while there is a 1:1 relationship between a
child pid namespace to all of its ancestor pid namespaces there's a 1 to
many relationship between a pid namespace and it's child pid namespaces.
IOW, if you change pid_max in pidns_level_1 then you'd have to go
through each of the child pid namespaces on pidns_level_2 which could be
thousands. So you could only do this lazily. IOW, compare and possibly
update the pid_max value of the child pid namespace everytime it's read
or written. Maybe that .effective is the way to go; not sure right now.

