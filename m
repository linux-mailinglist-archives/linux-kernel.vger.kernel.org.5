Return-Path: <linux-kernel+bounces-122916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF388FF65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D8F1C257F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0C7F49C;
	Thu, 28 Mar 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hvf5L1Nj"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2F7E10B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629805; cv=none; b=QstDDXrbLd7JhZbVV1gS7l5aBcndw774azAnhXo2hdD1plbc3LstNH+H7L9YevZx/cRXijLI9N+p3InZj1yKbQaoMBjkfImty1KogytnIapLRVWAM6Oz/1rkJBexOPwyLqkFqASA5/pU3QwbsraNaGhKRnJP0Dwnhop5FOx42pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629805; c=relaxed/simple;
	bh=wCjLEiLhsGuQ94t3e93iJvctAPVhr0te7y+obw6b26g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxjZr8vxpa9nSSZNKRGs63MD9a+SAyyayyI5NmA3vRXEHokJndYiiTLKzXbQBC5sLo3ywAqT3UH57/s0KUMRh6lfcoVNBloa23SQ2olC3/1VyPYmWD67PXgVIOGZcrRYTlRXABREzPNx8inTW2shOS2IxjnoYZnC1FOcCT1/hUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hvf5L1Nj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso924826276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711629803; x=1712234603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCjLEiLhsGuQ94t3e93iJvctAPVhr0te7y+obw6b26g=;
        b=Hvf5L1NjH4/ykBgdIa5Fxa9+LpTbH2QLO6I6Ik+wPfXD9pU5SOLOmLiJ57FguVH+IW
         tgYv8SqQSDYj5wp9N08GgrTgGKI6pFWXYV4funDAmXQt1GKrD/s1K20jwUKYELyGSyQE
         CngzRlMn41zkjUTCfszyPzDEovaa/ghaCFXANuwriEUJ+1ZWrJoiCs8X9aX8jlXG3QgQ
         wJtH7q64zF/WDtL94P/Veo4cXtPbdogJRNgWCJLmZs5h8tVdB+YssXUf9HUpHLkFA8Pm
         0zshluFnIv9eRPfWuquK8U/NZB0t7+EYTNLYUm0fzjkS2rvBEU3Q//X4FqoNkxJHmmzi
         YQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629803; x=1712234603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCjLEiLhsGuQ94t3e93iJvctAPVhr0te7y+obw6b26g=;
        b=V891ygXve0TQX+K8kwKTHAKy74xry5IKmh/M7wODbFSjpST4SgLF+eu/o50FBkwaya
         pZHn1hAkqmSe0khTmeAn++JU0q3Bcz3Cyr/SuqXOB+oKO15g6VKZvvpWd6flHFU80tlX
         bk7j80hha7LwVM6GL5C3yRn37kTdKHrVR+SukRm1GC15gg5gcByq1lQhjAKMQboRPpbV
         //q6rAvoaotCipnMjLMZSxvMvyLwew4x0C91cmHC6f/dPnuWGPx48JHHCaoRyhEOrpKG
         JH0AijOkWMf795X95klEZ5NNHHVvm7IAdg69eybdMk0t1IKoxSpxmSrmbKAxGZlCFWke
         Ig6A==
X-Forwarded-Encrypted: i=1; AJvYcCVTHtu1+BW9VvPHpvVCOVC7IM+ji4ZQxXK+QpSJ/TGEe0qUjn59P2fPaMWj3Lt0pUb4MBst8KowE57ky9BDSaCn0dPnJ4s3yN2IaP7Q
X-Gm-Message-State: AOJu0YxvrR6NQdNI1drPiB5x6Cq8/T9UD7XnSm/7erhFyxvjm1VVEopo
	4d2Nk96VkdMz8URdfe9wrXUNpC1wAoUmg04+DPvbzHJi7FruaTzv52zJ3CUmfq+sZiAnyzfw0wP
	fvIQe6Mp1h6L06xJiebkwxtt3dVYvntZ91MeD
X-Google-Smtp-Source: AGHT+IG7Hj+v9FZ9/91AWUqhCMCaVjwUtpSrpHnaDe3Rf5wZSA8LmhBKtZJ4gqRDkx5Ku7FJ96Rn9hqsd+NaW27OoP4=
X-Received: by 2002:a25:5f50:0:b0:dbd:4578:5891 with SMTP id
 h16-20020a255f50000000b00dbd45785891mr2423670ybm.65.1711629802827; Thu, 28
 Mar 2024 05:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner> <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner> <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
 <20240328-raushalten-krass-cb040068bde9@brauner> <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
In-Reply-To: <4ad908dc-ddc5-492e-8ed4-d304156b5810@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Mar 2024 08:43:10 -0400
Message-ID: <CAHC9VhR9EL0CQRKpdJ5C9DLnb8YKCNZze+WnpRxn10ZHKCKzPw@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:24=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 3/28/2024 12:08 PM, Christian Brauner wrote:

..

> > And one another thing I'd like to point out is that the security hook i=
s
> > called "security_path_post_mknod()" while the evm and ima hooks are
> > called evm_post_path_mknod() and ima_post_path_mknod() respectively. In
> > other words:
> >
> > git grep _path_post_mknod() doesn't show the implementers of that hook
> > which is rather unfortunate. It would be better if the pattern were:
> >
> > <specific LSM>_$some_$ordered_$words()
>
> I know, yes. Didn't want to change just yet since people familiar with
> the IMA code know the current function name. I don't see any problem to
> rename the functions.

I'm sure this is what you are planning Roberto, but just so we are all
clear on this, please do the simple bugfix to resolve the mknod
problem and then do the parameter change and the name bikeshedding in
a separate patch.

--=20
paul-moore.com

