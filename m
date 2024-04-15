Return-Path: <linux-kernel+bounces-144627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A768A488A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F70A1F22F18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186AB22EF3;
	Mon, 15 Apr 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTLWNF0d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AD224DC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164302; cv=none; b=nQzQQVuVgDK8B6O5CQ4CuhnQHoUu+o+Ma3gcAdCVWH1uJZFM5BjsQwG4XfRRJdfAa8W6KQAhKSm24wpPp7b8iojFHAUcmtdhQNq5jkMz5reChDVditLx0vxg7nOVkkc5g0GuaoyiVMrB2SaB7LHO7qNmWukxaMbDCHqN3rC6GG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164302; c=relaxed/simple;
	bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En8LjEYsntTsd3q60/hcMlK5xmllnPfZ+gA6sed+7mhxOBXZPrnYLRSOgqWwywcRR4ACLrw2V607Jh2kpMIHkM6O4DRUYzZ7a64YKEgEDH90hMMifPMe94rlkb+vU+ZkngBoknEreG83kEShy4wF80pyOdM2mDdO4dYZe+uWCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTLWNF0d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713164299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
	b=KTLWNF0dAahSHGxN+rWuXJcXreNmT2asKEMj4CThb2iNbYOLXROHrI9daAa0FveabApnqg
	Hxjgw0O3xyb+hp/gn80Ol+UXwFJt9TsmbhI5Xqg2rrKLmokRCNlfIsGEFPe5+HtGZ7aRo5
	oi0nh0pSU/8X30opbhn3si6lt6fTOL8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-Q7iwMjKEPwCyHUzwvfdGlw-1; Mon, 15 Apr 2024 02:58:17 -0400
X-MC-Unique: Q7iwMjKEPwCyHUzwvfdGlw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso1890929a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713164296; x=1713769096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zRocQO/rRgL1qKa5DTF7pfCxE7+mgM0HcYZDkfYtek=;
        b=L8Or7okBanUIdOmEvGnxYtsrRLQiCikfwM6gzcM0veFzCzRT9h9b9ODPxF7RXdsCEQ
         5EMZN/rHNGxxBIUJgVx7/uEmxIgzblIkd7WT59ozPWjeFlyravawMRKKwbtomriuee0T
         uzX9SF3pQ9uOR7nxnzIrNiQ2eRZLd17rUUTA9LNnkVdRRYzMR4JNwTlIxn3vAFr8MvmK
         9t01fr8xYRA9Hl6Le4BbOeV+1Jr1y6/HmnpTdDr2++FcfPFRJiu705Od1ywo7pngtd99
         gKrt9equ4B7PgbKHqZ72k6x3FHZsrdkQSyEupshTn9laeozLg+8s4kzNu86eAy/Xw8cW
         saOw==
X-Forwarded-Encrypted: i=1; AJvYcCXs1edKDWTEqKNJuJHeqKumu1RELxxaJjeRnXntL5zB2huQLbQt2fjQLOenFsdfu9AC2+mmXmVqwIHkqYqoAmm8XTGRt6YGag2iaTxy
X-Gm-Message-State: AOJu0Yw+5nJXtBnpULMSxV5YR2Kb8zlLk5gKYhUpqXEBmwP8xC1cbPts
	sgDbdE6w9mCWrv7DAGi0WLlaLr0FU1ktl/0cuyDTt2wOgxWtr8pERidU+CVO64mBxL65TZiNDOr
	Ne00CSyA8YGHZWWG45WNExiZVPbzZ/Qrih0Gh2vKiRdVyOgd5odP2dY5QBb1DSoXsqS0hmgb3ee
	N/NRikFIFdbRIyEdRdY9N1V8xAorXxPdrewa3k
X-Received: by 2002:a05:6a21:191:b0:1a9:6d96:c700 with SMTP id le17-20020a056a21019100b001a96d96c700mr8932592pzb.48.1713164296266;
        Sun, 14 Apr 2024 23:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfCe10Cxttrxe8F4OkPc7KjxC+SFTe/Z0SKvR0xbdRbE8/iQQiMdWF3kDr6DPf/3wtsnu4W5Rb/yh0o2uaUZk=
X-Received: by 2002:a05:6a21:191:b0:1a9:6d96:c700 with SMTP id
 le17-20020a056a21019100b001a96d96c700mr8932578pzb.48.1713164295965; Sun, 14
 Apr 2024 23:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67c2edf49788c27d5f7a49fc701520b9fcf739b5.1713088999.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <67c2edf49788c27d5f7a49fc701520b9fcf739b5.1713088999.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:58:04 +0800
Message-ID: <CACGkMEtufa6MqWkcsZqHW8eQzj4b2wCh8zFMSAuHkxpWowLmdQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 6:04=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> Note that the upper limit of ida_simple_get() is exclusive, but the one o=
f
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <horms@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


