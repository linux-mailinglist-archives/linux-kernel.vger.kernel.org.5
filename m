Return-Path: <linux-kernel+bounces-161475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AB8B4C82
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441361F20F21
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FB6F07E;
	Sun, 28 Apr 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOeyAI4o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65C4A01
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714319574; cv=none; b=HxRhV9sePXzTYVi5TLmCLF2ReytrkoGxx2KarYAat7V7FQcJXV29HARChg25aUJmaJl946F+R2xT63V2kQ/jRCWfYtEVa4nHm3HwpS2j+LWkuoy9JdQzIULFdcKBeP7tXiHCLIXyO9W84l7Fm2/CfniPHjn6TVRWt3OyJ3LCvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714319574; c=relaxed/simple;
	bh=2wIGyMsyZwzKQCoJugGWjKv1x94RRNkPSOrpppHoAXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kb7UOZJD7kVH+D4MvSAQt+OztzclH+zxBqgWmacPRg4N6qzR80C10fMg4FYnIRhx4c7ZMflvHjjYZKIrchYd4tg2oQ79pMySFqWtcVNm1ScjgxrdWiqiEJ0yBr+MnWyWZQrzFMJEwCD+yFVP7GkCn06NafH8R2LQPNQquf7MCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOeyAI4o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714319571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZykVLyPTHNf2oLD7SWZNyhDuAGshWhY8pTDiUHRDL8=;
	b=eOeyAI4oTxIIFDKYG2ZnGn3PIWdKFVXxoPJD7710PiVaEV3FNcABDIDa8Qwk5hPziB0mD1
	uVChteTdTNsBpNglaUzt4ECvx4fyslmvTeHjFrH3aWS+K95CMXzsISSJZVLZW8o1tDJDxq
	imc2QCksIi21z2oneNXQPK+eZ/Dpz2s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-txyoNerbM5O42PWMhgEmuA-1; Sun, 28 Apr 2024 11:52:50 -0400
X-MC-Unique: txyoNerbM5O42PWMhgEmuA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d5fed0e1aso409532485a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714319569; x=1714924369;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZykVLyPTHNf2oLD7SWZNyhDuAGshWhY8pTDiUHRDL8=;
        b=u1Vg1CqbMK/wZtT1DvhG25ug6k/IgfYrARWxfpUFdIU8om8yxx1yAb/NGa5ifNB2Wh
         jzFeaN0kuUGSK0q4mNaOQpbWPyeA+87TGxGtlmL76FMjeD8QtnJXBlIsYMZ2oFrtG1NN
         dWSnCvN+vBllUEArzB04MyMxb3w0ol64R//WOXsayNWGQz25Z6IXdqKvk3Hiv+IaXnVX
         JvDYr3mIt+q5LTk/9447XXqdyId0fgVM6e6Fd83DrlBlGsPT5d+pwyDyBdfU7zKTm41x
         a8idde1iXmrX6oheAAdvLyaQCAIb7xIPwihKrwdQOr5OiAV95nLCnt7RF4gQ2JUWHgxD
         8mzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6vDhCq606tCVhNuokAy2D4xitKfRxIs7tScwB/D3JjjNVoYKYVnZD6H7yd+1+IXUf3WsHkvbRqB7NPdtko70hSrfRsf2UjZ/qV8NY
X-Gm-Message-State: AOJu0YzWQz4+FgcyMQDSRIhvNDW8S3/qXm/Bf0ZF9QlA/FeTpFkWJlcD
	E8f5nnJf7r7Y/lJoHduDXnM/ToEpcHq9LFzUzBmTno+LxYjqXxK/p5kElyDm8VNyxd3CcIKk8Pk
	7AqqwmURLlBbqwihFRRSa3bVxHeVBPeZzSDEiPDTUYIHmjS/bK8xK37U44MI5lg==
X-Received: by 2002:a05:620a:2415:b0:790:f40f:e24e with SMTP id d21-20020a05620a241500b00790f40fe24emr1246036qkn.22.1714319569616;
        Sun, 28 Apr 2024 08:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4L7xUX8yYGMYzxvIA1MdWkvVCmQ2dXjpZqYB5j1wO4eQWjPg8MkRG9IFPdeS3YyjYksF1qw==
X-Received: by 2002:a05:620a:2415:b0:790:f40f:e24e with SMTP id d21-20020a05620a241500b00790f40fe24emr1246022qkn.22.1714319569338;
        Sun, 28 Apr 2024 08:52:49 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c6c:a300::789])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a20d200b0078eaf335331sm9718788qka.77.2024.04.28.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 08:52:48 -0700 (PDT)
Message-ID: <35b0ffe54f5e4077d5ebee6b82ae9ccd568dd77d.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/firmware: Fix SG_DEBUG error with
 nvkm_firmware_ctor()
From: Lyude Paul <lyude@redhat.com>
To: Timur Tabi <ttabi@nvidia.com>, "nouveau@lists.freedesktop.org"
	 <nouveau@lists.freedesktop.org>
Cc: "bskeggs@redhat.com" <bskeggs@redhat.com>, "kherbst@redhat.com"
 <kherbst@redhat.com>, "airlied@redhat.com" <airlied@redhat.com>, 
 "justinstitt@google.com" <justinstitt@google.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "keescook@chromium.org" <keescook@chromium.org>, "airlied@gmail.com"
 <airlied@gmail.com>,  "dakr@redhat.com" <dakr@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "daniel@ffwll.ch" <daniel@ffwll.ch>
Date: Sun, 28 Apr 2024 11:52:47 -0400
In-Reply-To: <4294e43a0165a36a063d74c7ef62fbdeb156f8c4.camel@nvidia.com>
References: <20240426154138.64643-1-lyude@redhat.com>
	 <4294e43a0165a36a063d74c7ef62fbdeb156f8c4.camel@nvidia.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 15:47 +0000, Timur Tabi wrote:
> On Fri, 2024-04-26 at 11:41 -0400, Lyude Paul wrote:
> > We hit this because when initializing firmware of type
> > NVKM_FIRMWARE_IMG_DMA we allocate coherent memory and then attempt
> > to
> > include that coherent memory in a scatterlist.=20
>=20
> I'm sure this patch is a good one, and I will try to test it soon,
> but I am
> very curious to know why including coherent memory in a scatterlist
> is bad.

Thanks for asking this as I think you unintentionally pointed out this
explanation I gave doesn't make sense - so I looked a bit more into it.
The issue isn't coherent memory in the scatterlist, the issue is that
we're allocating with dma_alloc_coherent(). And according to the source
in dma_alloc_attrs() (which dma_alloc_coherent() is just a wrapper)
for):

   /*
    * DMA allocations can never be turned back into a page pointer, so
    * requesting compound pages doesn't make sense (and can't even be
    * supported at all by various backends).
    */
   if (WARN_ON_ONCE(flag & __GFP_COMP))
   	return NULL;

Which explains the check in sg_set_buf() that this patch stops us from
hitting:

   BUG_ON(!virt_addr_valid(buf));

Scatterlists need page pointers (we use one later down here:)

   sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));

But we can't get a page pointer from an allocation made by
dma_alloc_coherent() - but we can from vmalloc(). I'll fix the patch
explanation in the next version, I have to send out another version
anyhow since I realized that patch #2 still needs one more check to
work properly
--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


