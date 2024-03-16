Return-Path: <linux-kernel+bounces-105014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AE87D7A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900DF1C215D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CD1859;
	Sat, 16 Mar 2024 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/XqFVJZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A410FD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550184; cv=none; b=ooQJLQgs85TEfPF+y4lQKQl4ebawuHmcGu3CzVpv1flEtdlIK74oJ2X6SQg+rEulomNCXD6dYHScUBXM0Gm6sQprnqe2XDZEZsH7PBGUvdnIc4u6nSrK9I9AzNrovAPu3ePHQBH9N5T5k1Nv8o4IA+E4L9eOD3fZOTbc1tAxjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550184; c=relaxed/simple;
	bh=G85EgciO0r4nmSjbRTtD8XIjqE1Rp5YnqXQx5v9ClDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5r1+yAC4htTlNLD4C1rk0i3ujBoRRgBBBwqMFO43LNhE0HEsjiSvkkaWWnBYGfLuXWZY6o4jNNPdM0HPuODCmYXiJf3lJErh9yNMLtNxdJokZjCCngU0JNqQ+oOYQLDwg4lZbHRsQ9c0kWQD+6NdD41/xFQuYhu0taS+rdELec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q/XqFVJZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd955753edso23493045ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710550182; x=1711154982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLLMWAavvENcilhjepbChj236Q1l/3BRdqQF+Z6+ICc=;
        b=Q/XqFVJZkdHQC+WqbPGNwSCqviPSx4wrNfJHL4AH59VCPXaLxZLYoj8PP7DxH0bOot
         DiE4kiB3VCoJj/Pp9UFscau1fdxJ2iYrqma8rMaM4YAbhBiHeUIDFg3U9gFBia2oW0Z5
         NOjTAzO+TjRveQ17+dDWCODOryal/jMajHjSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710550182; x=1711154982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLLMWAavvENcilhjepbChj236Q1l/3BRdqQF+Z6+ICc=;
        b=Zwjk4PwqMYQmzZYRsGrnKG0Mgf//kWjND+sfFg7W05HDMsZ62+Mn9RpesjH7YrnIyv
         iwpkYoL0LQHbMs1MwJIqkt0X9lPpXZyffOnOxVdTVq7yfCQSWclcRKGlxVndAVgbFp6A
         zUEWQTXLjGpngcp+Tpasa1uYZp0vOkOb1rT6MYIbJFbXwUHjQfAsDJY2JjRRgUo6j1UR
         wVvZYhB38scG+BvodRgRi7oQ86MJBUD78DDvOnZqjrIqEJQ0TrNfxWesxqLYB+hcu+m9
         oH9r0yKMZSvAIKQBgHLG5d400XbDPVmiMIZS2Um2Kzuep/nClaoOAy6w3HZ062HloUSz
         z6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU9sxemTE5B102o+yFUpgjwj+7xd2+0POtNRlNFOiIU8uEWd/h2FeSzCvIL9XR6R71hsVVmWKvOxXuoO68gr1n0Xaxh/emkD+Tdwoop
X-Gm-Message-State: AOJu0YxmLp6+8raiWM/IxuUrkGX6rTpKmvjrTm6eogvO0CqTpB10B7Ab
	4UVnBnHL+kFQdU9h+BfK7PXL/daiwRZyMCn+UyxTuoAN+L+kf8sHCxME/FbsyA==
X-Google-Smtp-Source: AGHT+IF49s3BVLjwTtIqW/ZinzEWsq+sR3dtAHnTmciy4asa47AzJHmA7FbMbWEg7vNUNVjSKMkz1w==
X-Received: by 2002:a17:902:efce:b0:1de:e4bd:73fc with SMTP id ja14-20020a170902efce00b001dee4bd73fcmr3808885plb.24.1710550182376;
        Fri, 15 Mar 2024 17:49:42 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id ky6-20020a170902f98600b001dcfbbb1ddesm4521261plb.7.2024.03.15.17.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:49:42 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:49:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	tsung-hsien.hsieh@nxp.com, rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZfTspRKFgrO9xCTH@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315094927.GA6624@francesco-nb>

+ Johannes

On Fri, Mar 15, 2024 at 10:49:27AM +0100, Francesco Dolcini wrote:
> Hello Brian (and Kalle),
> 
> On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> > This series add host based MLME support to the mwifiex driver, this
> > enables WPA3 support in both client and AP mode.
> 
> What's your plan for this series? I know you raised some concern when
> this started months ago and I'd love to know if there is something that
> would need to be addressed to move forward here.

Now that I've looked a bit closer today: I'm realizing this may(?) be
one of the first "full MAC" drivers trying to implement its own MLME --
or at least, the auth/assoc bits. I wouldn't really consider myself an
expert on the core wireless APIs here, so this might be an area that
could warrant some extra look from Kalle and/or Johannes too.

Brian

