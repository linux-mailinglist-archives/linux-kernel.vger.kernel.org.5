Return-Path: <linux-kernel+bounces-52089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81368493FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8DFB22539
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED70C2FE;
	Mon,  5 Feb 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="beqkxcnQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70388C126
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115712; cv=none; b=BESPPYbMtIX/zS01eYjjgOOq4ApSIOovkx++JOqtIRio81icoZvzse9p/q+VU2vHa5vz/DusmOMNL0opHGCADKAGp/VLAjA6jCVGdpznVsHH+QS03wyiksTwMeIgsF6flQr2gokuGQObhwcamK6Art67w1Ezy8+6rJRKqWgL6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115712; c=relaxed/simple;
	bh=1oG2K/BK5HBeoXuhf+478t+dkokO6s9sdayttYscpgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwTHeIvCXJFfsJXweoncwRIKImEOLwhvT4saDAm81iePyt9wFWLunsHw0nbsxJ1AitCweOOgUKUcupj/goZFnvkAtwaoB8t1NMslwQitN6DsKx8nrsnpAop2CNBaCbcADQgjSIYT35hEddb5uPCEVV7Tcj5tJD1BOth6CfxoXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=beqkxcnQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d74045c463so31251035ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 22:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707115710; x=1707720510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fZp49LWrBZvAva4h4qGlP855Yooh9hLpm+qn5WZrEI8=;
        b=beqkxcnQlwGJ77tElJL3w9cISU0GcgIYKENzc1v2xd3RShRLSCl+JrAHjpKeRtnPoV
         P1MlYe0S3jVmt3te63FiQtT3y3F9Hk4nSmrujGiTc2B80fd7cF0aMNdZluZwYjEEIn3+
         AvjrCrJMOpRvcj6Pz3ci5AUolgxxllSy3sR58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707115710; x=1707720510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZp49LWrBZvAva4h4qGlP855Yooh9hLpm+qn5WZrEI8=;
        b=RaoR4tXsoyo9WrcdLZaYRJvtuCohLlaJDZOoNjp/5HJsHjlFiU3RrpDchP8gcl+Tb8
         a53A6nTXWzkUCE/Cu4uuPlrKsQSDuVYnqV5C8XujKKn4mqV+A/5bjJsTjvxuCH6w72fy
         gT5ICw4wwk5/0Lgc2I3jq2Nb58S0pWJMd5A+fYVc8O7XtwYqDQxoSQajk5aWdd1HwzmJ
         G4cmtWVFUmUKsb1b6yg6KAMi2zqXQunHMvvZ8VybYRpthv0mvNOzGO0hocswJxKVbV7j
         jiMIvcPK/4CV6noRCfmCvVjyqK1//xpTZAWOOwVVUM2PN8/L6gWJk5IkX2Im6m90Ghex
         Wbwg==
X-Gm-Message-State: AOJu0YzETUe96eNkIjcAzKICryMIboyEnQlzXBcFdfixXzQ16Dgu7pKF
	epU6BRrVv4s0bFZlIJxb9DEt8h+4Dv3CWJ3aqsk9BN6nS+S1ajfGzot3ZvtANw==
X-Google-Smtp-Source: AGHT+IGnfOZtMxNg8h1qTb6hrvn7hMA+At3kcSMYu7DYozE4dM5cbZdvfqk/85wgP7frdmqklRop+Q==
X-Received: by 2002:a17:902:e5ce:b0:1d9:a131:47a7 with SMTP id u14-20020a170902e5ce00b001d9a13147a7mr3301516plf.63.1707115710138;
        Sun, 04 Feb 2024 22:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOlCQz0uICl2FN0MaWHy6oIw/UgIftw47P26HRWIH3JdDUdg+UBJ+ImwJVTtxPYBr50hnx8p1o1MI1qaBg53Seg3BIkhasGQv7pIOAMyDtk9CntBZOcYZlrdQ/hwmqgrnvd5PA27v7r5TCUEEYvLCzURBwxs/OE1UYcFphCuuv2F3lrRg7cKrTOOif3Z/ujshO9eTCYhlmH6ehN5JzDt0NxiHwSOlj9qI0seQG1Bca0M5l+DV7+ST72ntbVks07+entvdxvveqEeBDAWmtJ/K59JTKQ2o17IUSmQxKaCwKItzj9dsEFi27ERwU38tmH94wLRxG8/l7OH7GY+UI5cn6GpVFVBrIb0bJzSG+nP6qzGbHpuqy+qtmlRpOVxcmzDk6cDQuge7BTrddQVauCyiEqQ==
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001d8921f2058sm5523180plb.205.2024.02.04.22.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:48:29 -0800 (PST)
Date: Mon, 5 Feb 2024 15:48:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mark-PK Tsai =?utf-8?B?KOiUoeaym+WJmyk=?= <Mark-PK.Tsai@mediatek.com>
Cc: "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	YJ Chiang =?utf-8?B?KOaxn+iLseadsCk=?= <yj.chiang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] zram: use copy_page for full page copy
Message-ID: <20240205064825.GD69174@google.com>
References: <20231007070554.8657-1-mark-pk.tsai@mediatek.com>
 <20231008043855.GA2738554@google.com>
 <99a493e1e906637a179a80b1f27a4b6bd2a0a671.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99a493e1e906637a179a80b1f27a4b6bd2a0a671.camel@mediatek.com>

On (24/02/05 06:43), Mark-PK Tsai (蔡沛剛) wrote:
> On Sun, 2023-10-08 at 13:38 +0900, Sergey Senozhatsky wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On (23/10/07 15:05), Mark-PK Tsai wrote:
> > > 
> > > Some architectures, such as arm, have implemented
> > > optimized copy_page for full page copying.
> > > 
> > > Replace the full page memcpy with copy_page to
> > > take advantage of the optimization.
> > > 
> > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > 
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> I guess this patch may have been overlooked.
> Could someone please help to review it?

Oh, yes. Let me take care of that.

