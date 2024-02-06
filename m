Return-Path: <linux-kernel+bounces-55580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F8584BE78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F75B2513A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD217BCB;
	Tue,  6 Feb 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kh0EGZnx"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407617744
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250588; cv=none; b=CG7tB+8r/PV2aCG4X4TkC+AiArC+Mq7WfpKPSriGM8I1OaQQRAWe8TM0eBsZTFeqRzbfeSXUShFCFt7/qkcOQ7vzCjrDW8JJjqXAlK1r5ihbmN2uaLcgR29jV5Vf52xsxac0YFsX4K2QQ+YUCFlifey4DiFLTG5JNATJ+xwl434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250588; c=relaxed/simple;
	bh=S3wWG9LTmSphdVASpsfJh7lu61NHORPIUR+AmLJvQ/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/A0NsdYzOk2YF1bs2TTXNyUtzHw+ndtCvj3udFJX5nHxof7df4aPnQPpnojQQCXtathScjdNrQXmZFg3WtsIQYOuFxcyF2VBaekPNzclq+iDzGGrLThLOXNpMMEHpkvetsMad6FAaI8VjHlqpfwN7hcvlRcyk8EfT7CBWnxPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kh0EGZnx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so796144166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707250585; x=1707855385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7le/nZAlZWBvqI0RxW8GICAQ2PrKEymWw23KWwUuOaQ=;
        b=Kh0EGZnxOSNJ9ENhNFXwZG7s0+a4ktIpjz18w3ZOZcc+IFEcnhUO1UfASITT+Mq6Ib
         4cfdr6vi+GK40qG88cx5bn6ZcyJAJusSK8HhITN0yCROP3j3m7jG2Fk0BiKsCnIB+qzk
         35VVir2V3YgJyRVxsaFQgMHGnPUEjDWrq/+uANxCfoCv6X/uXH5UxWz6dTDkHX8Mw2n/
         OOo4F39kVHfm+xbwmXdd2g3PMzU+SrR6cPNEjxYbXIVJEADGnS8woaK9ZdczS1ZuEQxr
         aesdVJWNuJnDvc2bzk+RfPtBgCxfPDZgiGqkvd4GWPADj/rwTt7CBaa1k/dRq6H6xRrN
         Fzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707250585; x=1707855385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7le/nZAlZWBvqI0RxW8GICAQ2PrKEymWw23KWwUuOaQ=;
        b=DjXikECkSAtqR0Dtqje3pfWHnOf67xuSGv/8lD1s6Yrtf9M+HnRyDvisgIJ3KEVdcQ
         jdNethx6OVhjchAxHG33H2xCwk2d2t9bD2kLAw79dMF30tPx5dqvr4nDDLlMt5Lnhq0q
         0UenBOE56AY/bGHfsiBmV8m3ikWVLu6qxLf1UpKqwCsSwSY3s9//fRO3VnYr2XmL77KB
         5SCB+kknqfi+F8TrK47UnZL8hE0htoZvv4l51ehBIuDZVxzCLCeUnaRcMjH2akVi1zSz
         cLO+PY2aNJUf8pDupB28okcERYMAhY3cUMBvEShgOk+9RIHii+MfOEUmGODGqfV+kuuY
         bO+A==
X-Gm-Message-State: AOJu0YzVHOk5deG1SPbIXIB7ObF5kSh3K0/xlP01m01fdN3ROlDmoiQ5
	ds/XYRJJ4qzgCOzl6XSNbNmk2I49cvw22CNSwSO78DKidsplXE5SZKfgBVqfNmHwbN6+oqLqH6u
	5JwS8qysti1HtIQAe8zanrQ7+tgT875GSMbzRdA==
X-Google-Smtp-Source: AGHT+IEVs4Xs7p29Q96OwqRVeFJ8EMOehRF8A29Y2kht3xE/Ymr+45P+8l6jtmyV3CIs+8vJx1bx40ihmubL2LzKOTg=
X-Received: by 2002:a17:906:4088:b0:a37:1c56:8979 with SMTP id
 u8-20020a170906408800b00a371c568979mr2399908ejj.76.1707250584794; Tue, 06 Feb
 2024 12:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201233400.3394996-1-cleech@redhat.com> <5228a235-69f4-4a9b-8142-96d9b4a5a1c8@intel.com>
 <ZcE8JC0o9swkNzmr@rhel-developer-toolbox-latest> <20240206075436.4d6b11f2@kernel.org>
In-Reply-To: <20240206075436.4d6b11f2@kernel.org>
From: Lee Duncan <lduncan@suse.com>
Date: Tue, 6 Feb 2024 12:16:13 -0800
Message-ID: <CAPj3X_VQcnGwuG1OP4E4Qt=jwt_gStVigYS53BTVaL7PUnd4Jg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Chris Leech <cleech@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nilesh Javali <njavali@marvell.com>, 
	Christoph Hellwig <hch@lst.de>, John Meneghini <jmeneghi@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 7:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 5 Feb 2024 11:51:00 -0800 Chris Leech wrote:
> > > IIRC Jakub mentioned some time ago that he doesn't want to see
> > > third-party userspace <-> kernel space communication in the networkin=
g
> > > drivers, to me this looks exactly like that :z
> >
> > This isn't something anyone likes, but it's an interface that's been in
> > the kernel and in use since 2009.  I'm trying to see if it can be fixed
> > "enough" to keep existing users functioning.  If not, maybe the cnic
> > interface and the stacking protocol drivers (bnx2i/bnx2fc) should be
> > marked as broken.
>
> Yeah, is this one of the "converged Ethernet" monstrosities from
> the 2000s. All the companies which went deep into this stuff are
> now defunct AFAIK, and we're left holding the bag.
>
> Yay.

Actually, Marvel is around but seems loath to invest in re-architecting thi=
s
driver since it's so long in the tooth.

