Return-Path: <linux-kernel+bounces-122088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A388F1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D51B1C27C92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE015383A;
	Wed, 27 Mar 2024 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f+QJukT0"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C46153591
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578321; cv=none; b=LN3cqbWAOm8g0v++RhKcQPK3bAepGBakeQrC+qAXDAr9Rsdlxee7RhEwuuikPUcST/RqHPSCLpnmsJ0hMUIBT+fYUQgUAU8zhYNAK4ZNl1shaIfhRimQijsBbr5vU3NfmAmB8W2lX3cCRyxX9Hz0jz3CvNWAgJumZ/z2f0kpBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578321; c=relaxed/simple;
	bh=zvblnRjqyr9T+Xx2ZmU4DdKOyZ8u5C7pMHb7A/mXvSs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=B8LT3XX7DiIHxXY4H/fhPokt1n7SI+EqIvssUBcCyxg2CoINZ6VKLOdkSzeXU1i6/6f8u+gYoGnNw307pNSMSupfF+TjfqBzus+8bYlpZBtMc53czY4nVfauczVHJEEhBRgMLp6DA8bCixXA7DmsgnA0JqWdz+MEFVoCUM1kPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f+QJukT0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-696315c9da5so2394136d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711578317; x=1712183117; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lJ3wjFaeU9Ztiyd+gJSW6nXLmVJwkYytMN2nUftxCkU=;
        b=f+QJukT0jAngv/wLvWrZEm9Tk64blPq02R1Vk1PdvmYqtilE/L4ngpmMJf0q1Okjvp
         HSpyKX43ScrDYCZiWSt9o+yLkKwasOFewwr9+4Ullrb7713SDlfmFC4eAiH4/3URqkX8
         xh/3qJ+Dcx176AEFolsGV8OvH/dwBf8wENIAJ4iIfXXh+1UHfB9k9iAyhF5FL7sL706q
         gKpyp53YkPwmiQ43/PWJZJQ3OLxBj94C7oqoBHe0MzvhqwJB8SBVJYk/tcYDmS/m4tx9
         M5J0ooSyGwKoi9BbeXm7LZBRajhsHRECp8Qy5zm/OJs+po/Egten2KN2eBSZ6iuAfWwf
         JYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578317; x=1712183117;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJ3wjFaeU9Ztiyd+gJSW6nXLmVJwkYytMN2nUftxCkU=;
        b=mQRfYEjumIQEbXOLenoB8lO8+xGn1NkWOJXsYdcoOL5Bw7LHyQgHhpaKzVz0pUFAF6
         PfATsXdXpli+ABTF/bM/kov29/iPuDGb5NGhCzYgh+hYlEv7Iv+OnKAzXruKl2dq5ib+
         ywfgS7re3HkjWicupXK0fs6fFwqlvZF3xmO7Y7MMmIL1SsuCuRd1x2qqU/YBbVNRaY+9
         5tqVCmZ3+VUuJYB00KDuHKYLCqt4jLj3BTGry9SDj5RVv2wJaVoMlB19R5lZ13SP64rv
         ap7LStUtLu9ws9bAinz0taKNmUmsAjGTAqk4AOVChGG5JRcp2eY6cWRxA8z4fvIIZULU
         qCag==
X-Forwarded-Encrypted: i=1; AJvYcCXfzR4wnZLAt3sAvsYinGdUTWtB3/RRg0aKS694nbSreW+Rxw8WZZVrlmlEy+SPVaAxm4mecf7qHN0mXXtihYsvNM9tygRahT3j6pMh
X-Gm-Message-State: AOJu0Yw/uJaBHubPD/bWx2mBHsDV/eMfjbvu2tpN/oBI5cLoakUe66T0
	PQMLtNnQt1WnGtuiWfp8c0xhWhFRbPZHxV211KvThYjd+HN7ksLtQHxmh+Qb4g==
X-Google-Smtp-Source: AGHT+IEB1EtlYhSzjbkFAJS6d1yVX/gJOyNrRi/7DgIyCMvcLad2G6ZK7a6iGO+wA6rZSHqS0SZcJw==
X-Received: by 2002:a0c:f847:0:b0:690:f1e3:ca7c with SMTP id g7-20020a0cf847000000b00690f1e3ca7cmr990364qvo.16.1711578317661;
        Wed, 27 Mar 2024 15:25:17 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id js5-20020a0562142aa500b0069686d63c1esm44265qvb.69.2024.03.27.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:25:17 -0700 (PDT)
Date: Wed, 27 Mar 2024 18:25:16 -0400
Message-ID: <5da09fb04d92d9a4a9d7d5cc1ab14ebd@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selinux: make more use of current_sid()
References: <20240315173105.636749-1-cgzones@googlemail.com>
In-Reply-To: <20240315173105.636749-1-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the internal helper current_sid() where applicable.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 22 ++++++----------------
>  security/selinux/xfrm.c  |  7 ++-----
>  2 files changed, 8 insertions(+), 21 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com

