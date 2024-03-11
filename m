Return-Path: <linux-kernel+bounces-98614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDCC877CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2CE5B20327
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00906182D2;
	Mon, 11 Mar 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FonZ3Ej9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DC17BD3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149135; cv=none; b=qJeYIuMO5KOmvwAU352Kmi9/o8mfG9zrNX748w9G3dlHraPqs05r1UUg0ct3h3U3WQs+lAhhWrI5hnKhJJUjnPMPcOYkSHxgH1rDROvoLTvAJDwravB6NSVEzC3ACfGntklkCPvv3xQ9O/SpkQUnJg9kg6CrPPC4w1DOQKx/kVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149135; c=relaxed/simple;
	bh=vxgDEDHmPVdKOo18wugfaNuuyfadd5F4i/1ADxrjot0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+zo7JOZJkhSgyoT5NZzE4k3pTKaVPXYkN+SutynRZaUeba7uGH2yZPYZO7X5tx/126MqYZXjhK5S8mINc5ar3KzP7eLGCKsI19Y5MarU5MO961FvMWJhCtuTwZ/fbobRp2G/iFmdizx68ZVTcbwobd+4nMB1WYtpI9geN0Ngvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FonZ3Ej9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1139300a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710149132; x=1710753932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xweGuz2EcliYTpJB5JmcOmCcUiI4LLTlw3hou6Xw2WI=;
        b=FonZ3Ej9s8aGIt9tKqwLOMWP60H2zZvc6NqcdjCwfbZIsT1jc4+WNqTrfYuLbz8aZM
         C6AeOb5Xz2NCJEBfWVOyPjpKkTTL3L4W/Grvg1aEVtbQ2T8OZm7Xviq8fQ3Dm1vjVq/2
         SYnFeG65SEG2+DCRbYm8HZ9JOLhfQK7TS46Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149132; x=1710753932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xweGuz2EcliYTpJB5JmcOmCcUiI4LLTlw3hou6Xw2WI=;
        b=ubeiatFhR7QGR2krzYZviYbt4EeGhx+7bABpg1IfTHtgGruUu7O4j9Q01A2+m/99jw
         kfRNpT0I/iZtFPQRzYKwNQ6oV3jlHX3xEGquQxLyN8kQQBTDOv3Wh7KpsTNHXdOe2E30
         KMwqzrQqLdVjS3sbmCx9Pp2GnmZrfZNhmE3NpdkR/ubn+K4nDr8YXnOnN3xgVYX+jMmI
         CTQubK/h7cTh8YRPKfGWYgEB7wyI8y6uZ8PmARaBMMWEj/sjkgWG0ZDLnB2JQQmduw9v
         Obqjq+ztfYCHHpVSR+mU3uO8bUwscpO0j+RPihZZR4eBscJW5Uq2xn1WdAyPzMizsKa6
         q9iA==
X-Forwarded-Encrypted: i=1; AJvYcCWIv+91v4k39Zxwk8M5f+oE7NRRW9WytkRWUqesIVaWExKXWRZ5UA9myJ0VcxwFAUoUnd43H6iJPt+c0DsXhgFrvziwBL0nnfooC/PL
X-Gm-Message-State: AOJu0Yyb5bhGxZuIyXtuwSPawK6oORq4ig+3Hvi8WZYVn7lWb39PeNe1
	EJmWMCuY57zklJfvath2CVxEFiKzJpUi3Rt+UXpxLbZV4YcFZHZGPDW0WReezrMOPjbIQQC2edy
	WrBYYOEXXFhcX+eIcFb87B8irG0OO+H7KM3zA+w==
X-Google-Smtp-Source: AGHT+IF6gOthfnOOrsU1+KqBXRgXtuLD8ub1hx+m+9V+CldiXPDbe759oa1uJ0qJZanpOhfos8wXec/7mMMHKefYY3Q=
X-Received: by 2002:a17:906:f215:b0:a45:b1cf:42f6 with SMTP id
 gt21-20020a170906f21500b00a45b1cf42f6mr3725666ejb.9.1710149131774; Mon, 11
 Mar 2024 02:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307160225.23841-1-lhenriques@suse.de> <20240307160225.23841-4-lhenriques@suse.de>
In-Reply-To: <20240307160225.23841-4-lhenriques@suse.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 10:25:20 +0100
Message-ID: <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
To: Luis Henriques <lhenriques@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
>
> This patch fixes the usage of mount parameters that are defined as strings
> but which can be empty.  Currently, only 'lowerdir' parameter is in this
> situation for overlayfs.  But since userspace can pass it in as 'flag'
> type (when it doesn't have a value), the parsing will fail because a
> 'string' type is assumed.

I don't really get why allowing a flag value instead of an empty
string value is fixing anything.

It just makes the API more liberal, but for what gain?

Thanks,
Miklos

