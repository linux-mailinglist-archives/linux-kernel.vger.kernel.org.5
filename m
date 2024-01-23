Return-Path: <linux-kernel+bounces-35124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E4B838C71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1D81C2336B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF15D8F6;
	Tue, 23 Jan 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Gv6hPTxc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C25C8F8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006828; cv=none; b=lUwLtq8tvIFPfP7CjCT9T/jWAYe/OvZ6btVG6Yp7AGDopiU3B3Q1jgSvlDTEZeY6H8J+lbMX97FfPx6rbMCtnl2WRYAdgROw8sqhoEu9vTlhZ+Q4wOUl1ciwADJbNhx3he1vHdHVhI4QokBRfiouAmASHSepsCzADvcejeD8+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006828; c=relaxed/simple;
	bh=G8j7H5J7rDP4FvMEhKTL0JbUlW8oFRC6l0lnwfkhCIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMjWrvJizVCoVudRoDyKO3iyFykjlV0jBAu1rjHBd6TGiKSPSPo7fFujLVzGYSuF9+hEH9sZHw8pNDw1PLpdTm+KEx8tGyTPRdDnZMnQ1QgHQAw8yit7G/N+X1xHUjFOYW8/C5Aoy4ajSIO4UWnWSv5bUiyTLTd/BMgt3Q9tIKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Gv6hPTxc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so411287066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706006825; x=1706611625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8j7H5J7rDP4FvMEhKTL0JbUlW8oFRC6l0lnwfkhCIk=;
        b=Gv6hPTxcNfyPV+KnGwIYdrGw8466MV6nq/55cGfcWodLZEGexM483eQBvDqq3zUcgV
         Z9gJaNd9cxskSPS/6HxtBC+35O9PWeCeJEd4MXPBR5GTNcQsJlX8JWUfmIuu9gCsH0nl
         CiIMT2uxZPf14SMcysNGTzuhBM80dps28WPEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006825; x=1706611625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8j7H5J7rDP4FvMEhKTL0JbUlW8oFRC6l0lnwfkhCIk=;
        b=ZA5FgxcNROblMSABhFGfo4qtt7llPpht7FNEPrVmEYdqVeXE7dKuMWelCYqcKK9Ucb
         1zUwCCwN5tMbodm7AzKSdLJWSVfkk+jGWXvXNB+x41NWV1Clnz+IFh0zGrfwC5Pd3dYs
         6x7PpiaTlhl8dUoctCY0W4mOrihpza6srUm/keDU44YFrIT2rzxBL2X2EjNAj9qFb1V4
         NS2odf2tinCEH38fRNF6831Wk+8hGL8zXApoIa1Y9YGOyGWiLUVEOR5RGNe1Nxk0Wwl9
         /r5FXRRFXUWHrSMcEGTZZFDwKYLGAUT1HFRVpV377Qj1jh+PM/fil7LURsT1/JVl87kB
         qkVg==
X-Gm-Message-State: AOJu0YzPLK9kSEfrhaxOwmMHdm4JHD/1jPIAJAzddAp1kjdCDj+tDWUo
	L++7dqChHmXy/2XDJDWU82/3BvyYdWPlvjaJQoV9sYtA/8ccLz+E2YhU6Ko9DoUGGFVUAmBpORO
	cUQD+ZMY2GVClHpXzZg1kohGkU/WCVtC1slAU/w==
X-Google-Smtp-Source: AGHT+IFtbUZR8OmWGyvWUczd7feZISOtaN29gsqT9WrxRlrFjfmcZfac2pyUJ/sOqiWjm+jxvH57XzMntT/pOjaf1xQ=
X-Received: by 2002:a17:906:280c:b0:a2b:c6fd:e5e5 with SMTP id
 r12-20020a170906280c00b00a2bc6fde5e5mr2869378ejc.27.1706006825043; Tue, 23
 Jan 2024 02:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
 <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com> <3d1d06de-cb59-40d7-b0df-110e7dc904d6@linux.alibaba.com>
In-Reply-To: <3d1d06de-cb59-40d7-b0df-110e7dc904d6@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Jan 2024 11:46:53 +0100
Message-ID: <CAJfpegtwmngLUfKeziO3dDpJ-XGU92DFLwhTpTrEJ0vqHnHLJg@mail.gmail.com>
Subject: Re: [RFC] fuse: disable support for file handle when
 FUSE_EXPORT_SUPPORT not configured
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 11:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
>
>
> On 1/23/24 6:17 PM, Amir Goldstein wrote:
> > If you somehow find a way to mitigate the regression for NFS export of
> > old fuse servers (maybe an opt-in Kconfig?),

Better would be if the server explicitly disabled export support with
an INIT flag (FUSE_NO_EXPORT).

Thanks,
Miklos

