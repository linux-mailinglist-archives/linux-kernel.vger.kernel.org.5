Return-Path: <linux-kernel+bounces-128208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97E89578F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8091C21D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477612BF1F;
	Tue,  2 Apr 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CzgL9RzM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CD126F16
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069672; cv=none; b=Q4mkhbiQkUgAZxdkQ6qz7nxsaMMD9wEfXcwz2Apm8/Af70nX2PnphmAteMfO0dkv3qu1wVBt6x0v7yU30k61YZ9dqVUg7IbWRiavXGY/89ioLnOYbwKT+Auy/CckibRrN0CeSpUruL5lh6XQzmjFXYiugJZejaMiw8NiSc+nGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069672; c=relaxed/simple;
	bh=XhHqbYUE6Sx2oXD4UwzUkAidMzUAqX4XcQB43g8/Juk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grWAKoSZM8EnNspmBRONezxF7oHOV5deORvWTnRdWXdCLDxRCWhXDcdWkjL+l1qppeVeUatYGMNkaZdSPw7kGuplQTKPBygIvjgDz//7uXBIjY8UvkCCeBJF77/j1chQPUDaz287vSkL38WpmBjpGCAhtdPLmZkj+WP6xzbEwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CzgL9RzM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so10052361a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712069669; x=1712674469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XhHqbYUE6Sx2oXD4UwzUkAidMzUAqX4XcQB43g8/Juk=;
        b=CzgL9RzMGnY0+BA1XuU0yV6fA2fMLzh14fbb1EUNV8bPAXX9mn9Oo5pgYxhlLWgYm7
         7yR20Jy/Y+uZFal8F4S1gMDg6SebWCirAtoxgobYw1QFwv7EtRF3gQ89OA9cxslhdavd
         +QsuajtlLfo5zGMpPiGls0tkeISAQGGcDU6us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069669; x=1712674469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhHqbYUE6Sx2oXD4UwzUkAidMzUAqX4XcQB43g8/Juk=;
        b=U0h3o2DXYddhu8TV45CNTKene0KCMPKS9qL/99HmCCqvdkdZf+TUMZtAks0+l4G2s1
         VFt2dZlex7I+Eea0ZmeySsqPKlPCvJ3BdkCIboKYBVPo39MUs0Q9St4cMLgWHTCuuoHu
         HizgTCwEUY63FCZ+RgWxso4Xk72uTCWRnbZJP46Ryfim+ig3mhO+ie7jSSDUSw5kF0YX
         sf4UaDwiaTinpgYZRFUUqRoX+ov+Q9J0MMhPExvjzl9bikuO5zF4ejlI/f1ORCnr+IbD
         b6N+pC4aRxcGB+hW4oNTQ6ojKvzoQarjUpb2voPBNU63IVCVBPqGIHnxpY3P5BfIUMEr
         QaLw==
X-Forwarded-Encrypted: i=1; AJvYcCUT6H1lKXeVeXiPEC1UOVrFFTmIT2cngWjKuQV54Jej9JpgonDu23ZIN17rVSK0XQdMFVAYxXvEboohwmENoY7bx4w3CpkaK6AW1WsU
X-Gm-Message-State: AOJu0Yxq44krBilxIAok5FpCHXNWqWLkOapvY+5HZTnzDqvyAV/no0hC
	KCNwEZB7UfNxn6OMCPE9eM6QgTjr0sX4tCeOz3P5sJnJuu+87Vym76BYo1Obk9aw9nsJ3weC+zs
	ez9mSVeM4LCQf1T5koDL5fcP50hkU1Rmyp39jaQ==
X-Google-Smtp-Source: AGHT+IEfPsC0av5KNUW2YwqX9Ii2cWfCfOzCgMFH2tQFtuKqbx1k0z9SiaRv2Dtswp06nVXO7FYfzwuU2PtAB+0IZeA=
X-Received: by 2002:a17:906:f591:b0:a4e:1d5f:73ae with SMTP id
 cm17-20020a170906f59100b00a4e1d5f73aemr14164406ejd.12.1712069669482; Tue, 02
 Apr 2024 07:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
 <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm> <f6bbdf158f0ca7a12de9b9f980d4d7fa31399ed9.camel@kernel.org>
 <CAOQ4uxiv7xSUS7RDK3esa1Crp8reYXewxkr5fFbhG623P20PwA@mail.gmail.com>
 <CAJfpegvRDKS1kKrMPyqzmuSs8KXZ2ohpwp0nEzEf7e3vv940xg@mail.gmail.com> <fbd0b9e5fb765eaea98fef23e9e36f266d7926ea.camel@kernel.org>
In-Reply-To: <fbd0b9e5fb765eaea98fef23e9e36f266d7926ea.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Apr 2024 16:54:17 +0200
Message-ID: <CAJfpeguWCNDzAuDndB8pbcai5c+ux3KLtrAaAOuh74+wCtZBXA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 16:51, Jeff Layton <jlayton@kernel.org> wrote:
>
> I'm fine with whatever verbiage you prefer. Let me know if you need me
> to resend.

I'll do this, no need to resend.

> Another thing to consider: what about fsnotify? Should notifications be
> allowed when this flag isn't set?

Aren't local notification done for all network filesystems?

Thanks,
Miklos

