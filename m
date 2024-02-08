Return-Path: <linux-kernel+bounces-58455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C084E6B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ADE1F2C31E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF783CBA;
	Thu,  8 Feb 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAcFOIIv"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46661823A7;
	Thu,  8 Feb 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413163; cv=none; b=mQiOkthDWIAhc4/9/slZCjWAOwwC74zKo2Sd5FpdKDecWh6uycxrfYyyf4T06cV+LczzG5oTFsB7KRhhhsSACMgZKO2y0bDYpLQVfOxaUn83xoQDnP+VkJ5AorbjohAgu1L4ZRtDIMUeXZDFysc/8JPVwb56q0BLvPy0Z1h3QLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413163; c=relaxed/simple;
	bh=tJYRqYmM7AWojZ+rKn0b3WiKJHY9lxz4bCvXg4I/eoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kpcp2U8njpn8prH4u0qL8xqIkzRc2ItnYtzQhR/xWG6VyMsWDPz4jW7M/OwdwQ/GBqV7OI0cZIvG0Ol0tjx4QQcysPjNidwhz5hg9Q6biObbsQmBqmIKxgtCIFvzl91bi00Sdm346yaHXHLNjDx+uJrzjdOa7dMCRX9fQIleGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAcFOIIv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc747137b15so22402276.2;
        Thu, 08 Feb 2024 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413161; x=1708017961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJYRqYmM7AWojZ+rKn0b3WiKJHY9lxz4bCvXg4I/eoE=;
        b=fAcFOIIvlo0UwOIKBz09mgFVMD6PYylE4t5A9XuEwAHVVqs0F/CElSWGAo0xFzcjvI
         qZOmRjnJY8KJ93MnmzSyTIM9DBvGaXy2My2CiUt1cZBiZxe62tfnQ9vEh0trJ6dqnIVb
         d4dbNLXgw38FOQdrRLC8PYyE0oQ2ALNkqrwQ2ohYehauNQh67IY5+v9lLOWbd9Dd+SL7
         sr4xmvDmsIbSLDj8h/cAWtIgKNDJVMa70mEnfVhlOCttVUm3lVU3zbXLNz2DH+P0BHFf
         iKtkr1Wml0BkyXjoFaY3iK6NVFpbfM+CYS5uIOGUEz4Kp/HxLq2XB5DYjKzvJQoQqig7
         LaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413161; x=1708017961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJYRqYmM7AWojZ+rKn0b3WiKJHY9lxz4bCvXg4I/eoE=;
        b=VdUgHW4BSuTsAY9EkS4w9UFai4YVykknGhebClwqmcZ97lu8d9zfUKsSxKdIlgnsfY
         +AhExQEv6IoDM4fE73e2Dhlu01PXt66KgUGl9eCsb6QQ3cKbY6IbBS+FEbRgf/OPrY+/
         iw6RCxWx2deMX9keC2LWT4Zouxd64eVkv1iwR73mBQRTzqF/ZKHi0W+jSpUaRqIyR16y
         0plVQCaJuAFemQZ9zRZWV4ese9QEzOggUgQxDc6A18jREU8DcJgtdYKwRcqDhd2/TZHy
         aG9pSlf+wQ2CM4b9yIe7s8mHCE+xEhPDOCcFl9328BT5ZaiLMjoWKJfx6z9nUerDkt6k
         zK9w==
X-Forwarded-Encrypted: i=1; AJvYcCU6hSasKPQiPkMpfy8XRNvtTYIhJxoAH+ISAkkZpwdkoNkdACnA7JcI6eoCoBfq0BiAmOVpRF1+cLcTWRPOY5ROfY/ZsLvJhifawMPUnUstYqwJdC4ATS5bLfFGShoi99pHidMyVhAz4bi3bAuV38BP+nXTWVrPWAaqy1XT0kyx
X-Gm-Message-State: AOJu0Ywxb2hgHrts8uAttwS+QR1XPw+M5U2f4PSTlAx0Ynoy7panMzTX
	hE6pdG+Hxxsvl71Glvmz6lbtUjT9/GpMUakiklYQN7EAwDXrfJAFRNWOv3NuqGw/io/U7sXpizo
	NaHUyzIMIEjyUUl0a5XZh6vAv/wo2cannW+s=
X-Google-Smtp-Source: AGHT+IFUpgAjnbbhJ0a2EyzjE0MnSXCWfE3AZrCjWY4YH12c8dhmGJslXeSXdhXf10XmGnjFjQsCiWU8Om/W5Aj/ivc=
X-Received: by 2002:a25:664d:0:b0:dc6:4b37:e95 with SMTP id
 z13-20020a25664d000000b00dc64b370e95mr132179ybm.26.1707413161095; Thu, 08 Feb
 2024 09:26:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131134621.1017530-1-hayatake396@gmail.com>
 <20240131131258.47c05b7e@kernel.org> <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
 <CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com> <20240208072351.3a806dda@kernel.org>
In-Reply-To: <20240208072351.3a806dda@kernel.org>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Fri, 9 Feb 2024 02:25:50 +0900
Message-ID: <CADFiAc+i9i29SL0PM8gzmDG6o=ARS6fSrTPKNyqh9RLmWWB78A@mail.gmail.com>
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	vladimir.oltean@nxp.com, laforge@gnumonks.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub-san

Thank you for your reply.

> We're expecting a v7 with the patch split into two.

I see, I had not informed you that we have released v7. My apologies.
The split patch for v7 has already been submitted. Could you please
check this link?
https://patchwork.kernel.org/project/netdevbpf/patch/20240201033310.1028154=
-1-hayatake396@gmail.com/
https://patchwork.kernel.org/project/netdevbpf/patch/20240201033310.1028154=
-2-hayatake396@gmail.com/


2024=E5=B9=B42=E6=9C=889=E6=97=A5(=E9=87=91) 0:23 Jakub Kicinski <kuba@kern=
el.org>:

>
> On Thu, 8 Feb 2024 16:34:49 +0900 Takeru Hayasaka wrote:
> > Hello Jakub-san, and all reviewers and maintainers,
> >
> > It has been a week since I last received any feedback on this patch. I
> > apologize for the inconvenience during this busy period, but I would
> > greatly appreciate it if you could continue the review.
>
> We're expecting a v7 with the patch split into two.

