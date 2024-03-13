Return-Path: <linux-kernel+bounces-102442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5A87B251
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F48AB23DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4146542;
	Wed, 13 Mar 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xyo4DYAk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C761118A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358856; cv=none; b=CGbjzi4eUE7iqLM0310jmP+SuqEcb3OIl7qng7SOImO9vFpFqm5w+HKNlx7vNUImmpcrLNxdEYdnpQIcz5dvbeMeIEUe1wTEzVCecdJ1CrAQklncyVf1pE7eAK3JcmoQcLbRMOM8JK3NV0GESRdz3w46kGPNk5WGBiml4drJMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358856; c=relaxed/simple;
	bh=SyWLx/CLZ2dnkUztoF3Wet7Am+S0TMDdR5smm1pPw18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1N419ndy+1AGSW8hN3xsqEjRiVWsFvY3OXXFhXkEnVZFjA4nTq8AE1hsjGINE/kg1LoTkl6I5gV92xfyFrMueZ5OiTzfO+FtngvSpQcFNIi7Z1ANiVp0BYE1ZwSbHDuyrEnAVPWYeAsKepgde8a9kxA92px3IrIIY8mqewqGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xyo4DYAk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so307057a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710358852; x=1710963652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1Z+s/JMA2O1SWekv2eraMQ5ST+sYQkftPbTsPkksvk=;
        b=Xyo4DYAktBKt4yOuL0bWVYzZmpQfaCel4e6ouRgTHTPm7zUBuY3y/3WY/l43+RluCO
         i+P1PrwZ0ZVacj4jrE4qff53lWHk0Ivyi5NX8CYKHr5GpkZFQepJDg162r+q7MfLeE3j
         7DcGZklCkcgG8DoZbqQNqqQuEGwipSX2FbTIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710358852; x=1710963652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1Z+s/JMA2O1SWekv2eraMQ5ST+sYQkftPbTsPkksvk=;
        b=OV7D1JzcYhLMHsuMBHPLMYjmOthlkVPNM16GJv7Qa4mD+7G6iUrHW0SK13Im/w+6WA
         Fjj8cjvjszGec0pohvxqVuji80GybNsXy/hGfhbdG7++svG8UVI86DehtSNVE3MtVH6c
         ZolN5uGSk8R183NDynxKSyy01QDchckFewdbVxtBqVPVZcy3DDdpobnMoOO3y8/k0mVQ
         Wjp3cv+LW7Vh20OogWqv9+Zns9qG+n0tGTIXfWEhhVoH4NM41LT8ijWpeYAPPHo1gFm8
         5feQAAi15ze18bBQVtlraA3JzS1L0y2ZXvUcZVPUYMb+gfX680dowTDabKrRM8c/w8aV
         y2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2MzL1aIjO/clW7dKLUvSfyxI5t93M4QW6am5ObdB/wVeG+l8txqE0o6HgQfrQAzwyruOdjELeB4B88ESUxMviRfZpQbgYT3AnObJ4
X-Gm-Message-State: AOJu0YyJB9leOdG5j/uF2ARPEaMydAYuPgSNK4tabw24vCEDuZ1vX5A2
	31e7q6XNPlJgNnbrFYVosokWjnYWWC2P7yAotE+toRElvIYluE8f9wVW5IRt2kkR3o9xNWkZqe9
	yKXrg3w==
X-Google-Smtp-Source: AGHT+IHS4Z4lOToqARNNGH0Ikih+FBDgz4CbmiZUauz2FEnNTDql/f7CQd2fTm/dqXbEF4uU/60opA==
X-Received: by 2002:a50:d783:0:b0:565:edd9:1acb with SMTP id w3-20020a50d783000000b00565edd91acbmr5341847edi.23.1710358852669;
        Wed, 13 Mar 2024 12:40:52 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id da17-20020a056402177100b005684fc23524sm4117050edb.49.2024.03.13.12.40.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 12:40:52 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so307039a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:40:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXHiIj2QEcVb1A+7oYLYrzxoIxr6lcZ18cUywGCs2pJtlvxS3PSTfK3OqEhH9l9RlsnX4KDGf7mpws4thgqY9sYkW81eiDNIbSNhy5
X-Received: by 2002:a17:907:160c:b0:a46:4548:aba6 with SMTP id
 cw12-20020a170907160c00b00a464548aba6mr5254063ejd.56.1710358851872; Wed, 13
 Mar 2024 12:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner> <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner> <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
 <20240312-pflug-sandalen-0675311c1ec5@brauner> <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
 <20240313-matschen-mutieren-283c6e07694b@brauner>
In-Reply-To: <20240313-matschen-mutieren-283c6e07694b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 12:40:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpQicLYSZwUw8gp8iW+QZQM8i4UJa1=O4Ww_D0aVBQtw@mail.gmail.com>
Message-ID: <CAHk-=whpQicLYSZwUw8gp8iW+QZQM8i4UJa1=O4Ww_D0aVBQtw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 10:10, Christian Brauner <brauner@kernel.org> wrote:
>
> If you're fine with it I would ask you to please just apply it [..]

I'll take it directly, no problem.

Thanks,
             Linus

