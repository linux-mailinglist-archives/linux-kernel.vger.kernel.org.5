Return-Path: <linux-kernel+bounces-28948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23BC83050B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BD6287B06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C361DFE7;
	Wed, 17 Jan 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YstKBRn8"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7791DFC7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493821; cv=none; b=J1g+JYWMFe7cF1kooyX+y1M0L4Rs7fTI/9ulqz5/8Ji1doOJXab3J9hQn+KmTHhYXRy6Q5xtUUAA0lvrLNGeSpjNzNBSWmwJyiZg7Ji7NjQnrkL7jtvjYUSQ8VW9BSlRquQ+ZFn5r4FK+Mm2lvjQmsiMvTFLTyRQxFbErtUGDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493821; c=relaxed/simple;
	bh=OpJejToQx4K+knHEYte1vlfrkNX17TwI7s2cvuHEnbQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=sY8R4BgJAsHe2v14EW+kMlv2QZf/D8gDz/bLUiKYKL6NBQfS6XKSHGHNMFszrPUn5tqAcjd6iiRr6JJRoj/JBBEdG8Apzuiu4n/GX8ae/nFI0NNp9uAs9Zt+LExGFc/sGhsX+MXbHE9qjNDiZRPQ/uY/UNGm3K9aX5VxqoG8whY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YstKBRn8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4298fa85baeso173091cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705493818; x=1706098618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpJejToQx4K+knHEYte1vlfrkNX17TwI7s2cvuHEnbQ=;
        b=YstKBRn8esyrzF17VqqnquwfPv2J5O7vtIMGZspT39Uun1PgEy2L9ranfmmF5/59x9
         6XzkZXKkIAi/kTub2n8JddwokjcbOa3z/kqHAIIwhtuQtomw0fc2K1rgVwf/pWewYElA
         +Ma4AnD7AOqVrOtkKevo5QpxSaYT+GLLuwSN7fjZYf9zY9WyniFwxSC97Lrfi2SLyNew
         nx8aG/ykmV3Zo0CfUPO5UpkzquAa3n3QnNjBbPJ1Zy034sBK6ZZTRJOURS1j0t3D1et6
         VNmn3hJl9Gz7kWregzUnWiyFdjHTXTMeN2XAVkCbPYod1IEMZgMUpPkmAxTNiuf36QHi
         npwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705493818; x=1706098618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpJejToQx4K+knHEYte1vlfrkNX17TwI7s2cvuHEnbQ=;
        b=wrei+WndZthqxrN5mNe5CUI16MltTyuwRklHZcY6Wxx9OwY3T6vPDz8WNICWbLgdVO
         vyMivkQr+r2LYZj6dhQY/S3V6s221kp5XY6sWQyv+IGK3scZyK+6b/Def4sF9nvvwZTp
         lzTsUTkS06Tyxa8zc3gfc4qz24jMXMKrQhlzs8QYNFR0Nul3eMwmvz7xXgpIIrOotSEh
         7NmV2JTLDyayWmQeAbPBAVFQRzUm5ndIzbSpgtEWj2g+pZ0gZ+FAqnatix/gYzCs81ZO
         BGVVfMgF+d19ETUHjDsXTHoPBmCTSmtDKNLOvNY52ApGXXyKKLJJQdAYmI+MHzCTd5OX
         2D1w==
X-Gm-Message-State: AOJu0Yy9PLKbvsGzUpP6uM+sQvSbx6BV1RABopVuiy9tcRXo9CHMLbQO
	hzqgcIMzcvSN++9EvvOiyIF0Gwm1DyfTUuMuDV57txnmrob87x7J6WmwJH8T8ZDGO2cwYKeR09e
	4C695zxV9q+mjLuv1xsIwRLET9i+ft5/0A1n4
X-Google-Smtp-Source: AGHT+IGbkTp3VddTsYWxc3HXyEelUto79+MB2m+Pc8xfquBTdyaRHS8AqF3Ed1l4M4vyUINEDy5FtZlhuuyEIyuydLs=
X-Received: by 2002:a05:622a:40c4:b0:429:c6bc:330c with SMTP id
 ch4-20020a05622a40c400b00429c6bc330cmr150051qtb.14.1705493818526; Wed, 17 Jan
 2024 04:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
 <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
 <77ffee9a-cd77-6a09-10ee-bdf17bfca5ec@quicinc.com> <8ba84432-bd07-3e59-3638-924d5fadec30@quicinc.com>
In-Reply-To: <8ba84432-bd07-3e59-3638-924d5fadec30@quicinc.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Wed, 17 Jan 2024 20:16:31 +0800
Message-ID: <CAKzKK0rjSxezNWfFg7gv4yWPga=_P27OA6O0OOVrHbiutJ53og@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
To: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> int ret = dwc3_gadget_soft_disconnect(dwc);

I'm not sure if the coding style in this line, where the declaration
and assignment of a variable are combined, is considered good
practice.
The other parts look good to me.

Thanks,
Kuen-Han

