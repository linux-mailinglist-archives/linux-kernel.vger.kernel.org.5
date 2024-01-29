Return-Path: <linux-kernel+bounces-43041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD0840AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C692B22D80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81179154BFA;
	Mon, 29 Jan 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PFMK+OgK"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B131154BEE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543725; cv=none; b=HIcDu2R/YUtiBcXpmKch4Sj/YYIWqV49grKF7L+Occ2C6/tJJTUmhFVRJ2pOWuAg3a2J7S8JKK3TR6MFWg0uMh6yID2ptLK+Q0CVnwYEhq9X3mpi50R566T/am81KGB1r4abwLXbsp+QPW7kw9LyvagHTptJNb1d+RfXQSqT89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543725; c=relaxed/simple;
	bh=tI5LA+MUq9JhjZhLhabItOUMnv5mSDCLQ3Xz8jFIF/M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h/1vSP+88qIXOJiMxjA1L6fbbi940jBnLmD5mWUVGLh3lygIK7vDoxs2Ml4r40VkH0HlBdysgNuVLZI9ASvzArcMbn7/IJWS8ymSMLifn4hA0AxPPvMoFUN+SxStYibN6zI27BkW0aWjaFe6YSa+MfkxO+/Tc1WrG4ZA8MyBUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PFMK+OgK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E1173FDA3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706543721;
	bh=jk0E+s0/Zi+TYR36QC+b5NfI3JWS1PpST8+F2bmxeZM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=PFMK+OgKk8GixCQ4Qmy+8MauVn/10B/HP1W96VFAJRdT0rGEqCvpZvqTfMl9CPS/L
	 TBSWQO/Fk22g0fS0pLkM7jeJhxT8d7+6nSXxj71gb365kxX9uTGsE1Jn3kBFBzT16H
	 V5Ns1ue0agPdk8fxlyM5zjbD6BUde/bn8q6ShMCDfNX30PHYv1IPhmUkM0kB5UZ97Z
	 pdfpKrFqp2ltYKcFef6FGjRizhq+U6VH1KTUpS4+8HEWjRHGBVMzQl5GdUlTGnuRym
	 AkF81DyqKnRIzmH3sAfZgpdPAFddNJN/cPxkmvDj/wP2/Dyc02rzbLbr96z5wA2zgi
	 +imxxu3zNXnsQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2cb0d70d6cso149117566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543720; x=1707148520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk0E+s0/Zi+TYR36QC+b5NfI3JWS1PpST8+F2bmxeZM=;
        b=jEWEIdR39ndCeZ7CdfEKv1yo/lxdKw6niKc2WH1Vjmvg3gdaPEonMAj3f7T8zt/B68
         kwbf6t1gHo4V2H++CQLIg2fNZ3rwa3OK/fz2UNTf4cIqZsD+q7ns4oH+WVk2h8vCdxVj
         Nq0PG+S7/AfDDn4VjO96wIfhKAMvrs7KSH1UZHtZDLFcKRhwjE5X1fyZ3y73XM1L6MlC
         FLfarSVq1aHRH/dt3q11ht2B4SQW5UcvPkxdqXZY7A3C8lULUAwbwmIYDZfXeVBzOXzp
         SlqeplxRlXGN2TnPIRwJfcRzR5WE9cTvN7ndH+jHe+jfzZE1HZjun8X5ls+rqzIuY2RS
         /7dQ==
X-Gm-Message-State: AOJu0Yzkcs00DVBN4O/fVlvWWvbxMye1556YxGDkk1t0lE/dgLXzx30y
	IPGvr9jPWujg/Zh9Y/WsaK2LzyfeYZSXIBCf0YjFJsadNGsISQvYgJwBF4DV44bkeUFJF0sFuKB
	IqH1pqQ2xMcdYNC0MCdf0wgzaVT7KnpJhMy87d9Vd66HC11EFyt4bylEkImFggiQzeZO7F8NAAU
	uasQ==
X-Received: by 2002:a17:906:e5b:b0:a35:c8ce:ca0f with SMTP id q27-20020a1709060e5b00b00a35c8ceca0fmr1565476eji.24.1706543720717;
        Mon, 29 Jan 2024 07:55:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLfUtsCr2johKWGnRfhgTv4nloHpGOJIu76RsF83V1uO0cs/AkByjmexnmxpRwJcl5s/ioXw==
X-Received: by 2002:a17:906:e5b:b0:a35:c8ce:ca0f with SMTP id q27-20020a1709060e5b00b00a35c8ceca0fmr1565458eji.24.1706543720400;
        Mon, 29 Jan 2024 07:55:20 -0800 (PST)
Received: from amikhalitsyn ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id dq5-20020a170907734500b00a26f1f36708sm4052159ejc.78.2024.01.29.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:55:20 -0800 (PST)
Date: Mon, 29 Jan 2024 16:55:19 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org,
 linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Bernd
 Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] fs/fuse: drop idmap argument from __fuse_get_acl
Message-Id: <20240129165519.06d348cfef475bd6a7b0b073@canonical.com>
In-Reply-To: <20240120-bersten-anarchie-3b0f4dc63b26@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
	<20240108120824.122178-8-aleksandr.mikhalitsyn@canonical.com>
	<20240120-bersten-anarchie-3b0f4dc63b26@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jan 2024 16:24:55 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Mon, Jan 08, 2024 at 01:08:22PM +0100, Alexander Mikhalitsyn wrote:
> > We don't need to have idmap in the __fuse_get_acl as we don't
> > have any use for it.
> > 
> > In the current POSIX ACL implementation, idmapped mounts are
> > taken into account on the userspace/kernel border
> > (see vfs_set_acl_idmapped_mnt() and vfs_posix_acl_to_xattr()).
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Bernd Schubert <bschubert@ddn.com>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> 
> Ah, that probably became obsolete when I did the VFS POSIX ACL api.

Precisely ;-)

> Thanks,
> Reviewed-by: Christian Brauner <brauner@kernel.org>



