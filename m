Return-Path: <linux-kernel+bounces-68615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E00857D34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AE1C21E26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3B1292EB;
	Fri, 16 Feb 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdKBommB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175897869A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088875; cv=none; b=XC8slMZiH7747oi3gKse7towRX38WPSi4qvoLPifz3eYersoryIkFroUWBqvitGtoNXvYlSccDCq5DEbPZ2XNmziOmLeFU0DJYVYBtxszKL2OnTFPVdjAvmoX8gRrR+04QoJphMcSt2lh7+u+6v/Y8db8PdoZWdaE8EOzM0BHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088875; c=relaxed/simple;
	bh=pPG3R/OErTmWA1YaPaPl80i0l8sVL+bI6w7kjgG1990=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwdAdwi8uzr5KcScf579JEnCtLJBTL/ZIJ/HVHylhlBC05qzcGgdg0njpw0ZhsvcDvyr6RySq5toFGVONkCXDAqX9Frsg44NEu0/OtfRmsurjyX7w8+jJjvk2MdV9UnvmGWNjB02GKjx4RT1TyoQlbk7+6ED3OC3TPT9wj9DuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdKBommB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708088872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEE5vefXCxxll9I1yPyvGhbZ4bDFBlmFBtJG7JnBVrQ=;
	b=BdKBommBzDNNdsbTT3YWURIlgkKY0WyjYBcVYXOJEESbXKebZqECMpu+WAoczw299BXUBl
	3rRIRuCnZfxQtJ/IEbBViWvca4xZzp/OLn9IpOfS1FqGYSxUfNE7wUIY1fDg6cseek3c4G
	WLzDcMh0RLIliQQO9Sjsiz942WEFb90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-S_YwwsXwMYGM4fFK26JqPw-1; Fri, 16 Feb 2024 08:07:46 -0500
X-MC-Unique: S_YwwsXwMYGM4fFK26JqPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0451685A589;
	Fri, 16 Feb 2024 13:07:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.116])
	by smtp.corp.redhat.com (Postfix) with SMTP id 27FF52166AE5;
	Fri, 16 Feb 2024 13:07:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 16 Feb 2024 14:06:28 +0100 (CET)
Date: Fri, 16 Feb 2024 14:06:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240216130625.GA8723@redhat.com>
References: <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-albern-aufwiegen-1de327c7dafd@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/16, Christian Brauner wrote:
>
> On Wed, Feb 14, 2024 at 01:36:56PM +0100, Oleg Nesterov wrote:
> >
> > and I am not sure that task_pid(current) == pid should allow
> > the "arbitrary signals" if PIDFD_SIGNAL_PROCESS_GROUP.
> >
> > Perhaps
> >
> > 	/* Only allow sending arbitrary signals to yourself. */
> > 	ret = -EPERM;
> > 	if ((task_pid(current) != pid || type == PIDTYPE_PGID) &&
> > 	    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)
> > 		goto err;
>
> Honestly, we should probably just do:
>
> if (kinfo->si_code != SI_USER)
>         goto err

Hmm. This doesn't look right. The purpose of the current check is to
forbid SI_TKILL and si_code >= 0, and SI_USER == 0.

SI_USER means that the target can trust the values of si_pid/si_uid
in siginfo.

> +		if (kinfo.si_code != SI_USER)
>  			goto err;

See above...

Oleg.


