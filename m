Return-Path: <linux-kernel+bounces-69920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1653685903F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6515283099
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D217C0AC;
	Sat, 17 Feb 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DbaWaxEy"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FC69DE6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182155; cv=none; b=NHu3pPt7baTbQJvuk6bZiuFEBJ90jpp8MZ9o80e6glfQh+HXN6pYeNN6mFXikpuspKQ6hLZfR/ZW5h+IDEJSN6dhj/g7Xa8YufgBPwuJ+D/DK2evFndmqHTlzwHRIsOcu5uAPLku8d5YHoeGal4R7HRgZLV137qRPLIrAN3ROVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182155; c=relaxed/simple;
	bh=ILCeUUqi0K9sqscq3X9d3q8gBc3poPrNqIRw6KjseAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp4DGDPnlepMgvbU3Po99W1F+ubuXDfHidwh6T7pWIAPEo2SpURMaCzYuUsifARdjPD5BdLonxYGoXvGUJgNO+rqz38q+96VURFKpR52yUvZI7LvSUlYnDnJOQVlxjW5GfOwJHVbb6P73jr6jxRDnya49cSY32HN8lf6b8HJEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DbaWaxEy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d1094b5568so39543381fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708182151; x=1708786951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILCeUUqi0K9sqscq3X9d3q8gBc3poPrNqIRw6KjseAA=;
        b=DbaWaxEykx5SWamSgjEVvxykzZOcw6ITzGZ8d9aLvXikhAW7iGiplMkiWqRqBAG4LG
         SfAb3ik5+3/g5av+O2ytLZjnxo/mngS7q0YSV6ivAuLjLH9s+ggUZqhJ3iAZHNZmJ8F8
         Ip1r0NkxAn2PXOzlNd0SWH3JUVPux1WRaSU8k3g2wa75KCrBmUPXq28F7QLyI2ON7yMv
         0vk9xUpPuvb51/v1Zt/+/jCbM7G2VdzQMM0n9BcTj7Gzz+1P0CRuG5r6LH1o2GMA3c9R
         25uyLToNLUh5o4Dx1ucGPwUSAzItphKf5W4Xyyi4aE7ecQU0/VYYE/fVuGnqoBAWpFjN
         qlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708182151; x=1708786951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILCeUUqi0K9sqscq3X9d3q8gBc3poPrNqIRw6KjseAA=;
        b=Uzv0bRWPH3MTZIN8YH7kjdutC0YPdz11E3n+5RKNEZpYq8LDbQBYFImC2DU3P86G+M
         BQ6wdpACfgalD7RpQe31hOFPNoB3O2ilVMxwT6LmIy8GGoWbu2uGRN/1zxXmbRnZW4Pj
         q/Ivf79+v64FttNqxGwl4qQ7ljd6vbK9bc3rwlMeL0BEjssXfeBOOB/CUuc7rbPoR3AJ
         nYDKrDboLpH3luV5m324vyUHg3yZbVlQl2CNjK/dXcDFeX2FIxpL6o6JjpB2nEYxnhoR
         qBUvr2WOCeSabed0QQFqr0hUySsrdaspkrDiP2ga/B/IQhe+zcSk+W7y6ti1kcUBQ72X
         XwJg==
X-Forwarded-Encrypted: i=1; AJvYcCX7wmto/tgJE83weOWQTQ/j/T/dr5ocp/gPu2CBmTMrG9V84/Pk+7+4V5Iw4eXTocbfsdLE9YsZCi6Ea8f9SI02bhutxhTVKyYDnCEO
X-Gm-Message-State: AOJu0YxR1H9xV8c46uwfayAgSJeqQuK303LjK9XYystOJcTsfojepCSV
	oDiR1/XcEKJQez9s0MxXiB88yG0yScTFd9oPiiXxg0d/GSWAU+QxbKbe5zjE6JZqzImM9i94y7q
	YuoPo7h4YB41EYnzS56KbAxOOclEdMWEfbrVVRXtwqvuYiAaW
X-Google-Smtp-Source: AGHT+IHIvT6p5SFDjLypooegrTTShaNlCq7WSa8iZzwV/mIUJGxt4t+vltDqbecDjgqMkCpNSHz69ELYR0ozXioW7I8=
X-Received: by 2002:a05:651c:2123:b0:2d2:2e8b:6eb5 with SMTP id
 a35-20020a05651c212300b002d22e8b6eb5mr825990ljq.40.1708182151371; Sat, 17 Feb
 2024 07:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215141321.899675-1-max.kellermann@ionos.com> <CAK7LNAT772pZEV09nEYTLOyU_og73zPkKjjL54e8yor-tnnHtw@mail.gmail.com>
In-Reply-To: <CAK7LNAT772pZEV09nEYTLOyU_og73zPkKjjL54e8yor-tnnHtw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 17 Feb 2024 16:02:20 +0100
Message-ID: <CAKPOu+8OTqBzuX5vdg9FR2hSSpem26BugYc2h2QY9Bh5vSRuGA@mail.gmail.com>
Subject: Re: [PATCH] scripts/mod/modpost: fix null pointer dereference
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: nathan@kernel.org, nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> Can you describe the steps to reproduce it?

This crash occurred while I was testing an (unrelated) patch set with
"randconfig" in a loop. Unfortunately, I don't have that config
anymore, sorry.

