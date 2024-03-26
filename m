Return-Path: <linux-kernel+bounces-118279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F041688B734
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0845D1C34006
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246604E1CC;
	Tue, 26 Mar 2024 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSdp3gjq"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E61C6BE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419094; cv=none; b=XJVVzYfzuY0wDRwUluCnVr9srySw6m+gYFgZg8TzQ0XxdqyeBbEkbPmfazT/Xy2ikZQk+coXaDgjAlBi52fGD+eOp46QzPMN8g/b+h3ixhObE7sPkzMBMvadBHiV9LwomKt30qOZEmK9OWO3G6aIftIKPzBYqQYAndmHNZrwej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419094; c=relaxed/simple;
	bh=2omgm0oVwmFQY0df3M492JuLNwzHdhr921AZ7TN/Hv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IshP8fVft3XNGDLBEZR5xh4y+HXD+GK9xpV98Sq52uEcAVbDBj16VT59B4J/Hx1r+S5RNFqEaPzZDKqZSb7PlVoFw2tt+au/SbDTrv8Yq4t/oBa8VUOL6v3ZTE6+jn45rKYoXW+BcRv9yfxXRmCD4g1Q8h029RauuWirIwTy/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eSdp3gjq; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-696315c9da5so39419976d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711419092; x=1712023892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2omgm0oVwmFQY0df3M492JuLNwzHdhr921AZ7TN/Hv4=;
        b=eSdp3gjqsDTO93dxhWHaawckcq75zu/wlY9NyaPJcl9ra1K1NYcgesDueqZ2R3MzIc
         19dP1gVirJ17xEe11y8wYJiRYPnUomJKCIjiW9xVCp2tt5uVfi/bGWuFFjVY2llkXqfJ
         CnfM/aESEjCUfLwfe6J0MaccHfwLnQ70mbbWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711419092; x=1712023892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2omgm0oVwmFQY0df3M492JuLNwzHdhr921AZ7TN/Hv4=;
        b=lvoZFfuFuis/LCjr4M2LQt+ZfFlVHuvakwvUaASWIbg/0lvkZLBUgA8WF2gSgksqWG
         KhuVyN67F3vBZUC2YnsF47EkwOqt9YAYvphu1jX674/ClFDgdEGK5CSyv52uri3CFLT+
         V1267LUUIcElH5vBqONnxC2cPNCF1BZ2nDNy83ecOZDF9+bZv/ziX5A3ZwQHYiZqJ3lC
         h0gL2ngHIO3IF/CJ+rv4DbME0a5yv+Q9DK3R8jTPlqAeLH5mChhUKZgcWGUxlr0gdbml
         HL0IKPlmb+IH+U2PdxSgrD8yxGqtHDMkdG10yuqau194zOQM/C0YmWwoniTayNR6DOe3
         3jXg==
X-Forwarded-Encrypted: i=1; AJvYcCUiqaWXP+5QwXPj5SfX5UXydncE1YGeNc5vo/037GXIPLe0WhCXMZLO2/DsKf1dZjQUi8HEFjULGF5AoBTFzuJ1+rgrjBUtUnmkfihZ
X-Gm-Message-State: AOJu0Yypd1uU8tWWT8zR6ePGoD0bLtsAc5tbbolxhbfMecpaiH9iujQw
	uNd0FKsNbzeo6tVu+I9rxEoUefjZcFr8oxZNDvcQG6iUcM+7r/XiMJ3BF5mvCyKnwj/nvOijmbn
	OuQeN80T/TZIrMspWSHr7dqi4fY/X4JdLOoGh
X-Google-Smtp-Source: AGHT+IFcIOWbn/HGLYRUnQpkj83Ev0HVBfuC4tfZaVnBO+TnfjywB0pWS+oOPTYuoffaX1zwBb9JPwT8JIdQku9O9vk=
X-Received: by 2002:a05:6214:2681:b0:696:51aa:8a6a with SMTP id
 gm1-20020a056214268100b0069651aa8a6amr12396926qvb.18.1711419091839; Mon, 25
 Mar 2024 19:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org> <20240325-public-ucsi-h-v1-2-7c7e888edc0a@chromium.org>
In-Reply-To: <20240325-public-ucsi-h-v1-2-7c7e888edc0a@chromium.org>
From: Prashant Malani <pmalani@chromium.org>
Date: Mon, 25 Mar 2024 19:11:20 -0700
Message-ID: <CACeCKaehH3Qs8y-W_jsyOdnTYWVzgsGj5_wGujjYT2Sr8xxqkA@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Import interface for UCSI transport
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavan,

On Mon, Mar 25, 2024 at 4:37=E2=80=AFPM Pavan Holla <pholla@chromium.org> w=
rote:
>
> Import include/linux/usb/ucsi.h and remove any duplicate declarations.
>
> Signed-off-by: Pavan Holla <pholla@chromium.org>

Can you squash Patch 1/3 and this Patch (2/3)? It sounds like an
atomic change that doesn't need two patches.

BR,

-Prashant

