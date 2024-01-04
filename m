Return-Path: <linux-kernel+bounces-16810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63B824439
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DB5B21E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451F23758;
	Thu,  4 Jan 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRhEHtDD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135823760;
	Thu,  4 Jan 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbdabb23e91so508849276.3;
        Thu, 04 Jan 2024 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704380119; x=1704984919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDsf78DtROBEHAyiMj330wxBlF+TDWhKu0EggZUYug8=;
        b=VRhEHtDDjoEZXss88gwGWujQLXNO9X0nlYQnEELcCox0jYUGZ7VpEIY2RibTTBLhLw
         b/nvj3vDC3UWGXT68xUtjpDxr8jrJs2Aidr23K0ISsdKwEcwIj6i6HdlQvDjfTR5KRX4
         g2Cv9ZOdVVUG6Nza3FmJijIOZx5YrHAEP7X13pBMtL8cG7Pww0ILcXtCCrejbP+Y7LVE
         jXUFDgJAnaIS8hVgTTpgnqg9hqOasoD8kPEXguO+lVPyKEu2rJto+/zB3Kdb2wN3yCfW
         G2d0Y8bmJmC/ScrOdYJ/LCKk95n+6ItcaBAJ5egK8ToMqjaSeYYFxHRfXDsstIb+gpMm
         SMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380119; x=1704984919;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDsf78DtROBEHAyiMj330wxBlF+TDWhKu0EggZUYug8=;
        b=jhY0t1mui9zsow3lJ9GKHePpKIKXILjzD6O74N7lYXq4UlPONC7vtDYOVVm1Umq7Ec
         pwweZWcCOf+tX2I7oP265QDEcH1zHP/b+MGz/M2OvmalQ8jsejA8SImz5Yc/uu6W83WZ
         WaDJzyUns0RvwtlPMwmmiMB5+lWUu89MG2J+1J7CSy0veluJzOCE4/QFXrta+/4DLzPN
         GXJ/gpQq12L4EvSD+YnEaYZKA8EKLnr8JL8napkOyX7fQLVA4I5WrLRhtmqJf1nTLqir
         BRjENk/Mb9AxCvJXelJdYlev2vu4hyehWcCY4wBJYOlBdefGAAXmoespt1fJndUVdntJ
         ao1g==
X-Gm-Message-State: AOJu0Yy3dxEFfA3+Aldh4FAAaqDq3rORWFvcI3EQrcAGQ2hC804nUFSp
	RXN53DGavxKXXWvminFPPPM=
X-Google-Smtp-Source: AGHT+IHebGoU88KckLJdxG6uK35+/srp4Jh+P7cp1upkBgpdXpvRt1UCihQClBLc0+aGVcjpIbLYfQ==
X-Received: by 2002:a25:abcd:0:b0:dbd:738a:1883 with SMTP id v71-20020a25abcd000000b00dbd738a1883mr630074ybi.78.1704380119351;
        Thu, 04 Jan 2024 06:55:19 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id lg14-20020a056214548e00b00680c848f307sm1670484qvb.142.2024.01.04.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:55:19 -0800 (PST)
Date: Thu, 04 Jan 2024 09:55:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Thomas Lange <thomas@corelatus.se>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jthinz@mailbox.tu-berlin.de, 
 arnd@arndb.de, 
 deepa.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 Thomas Lange <thomas@corelatus.se>
Message-ID: <6596c6d6d645d_4bb912941d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240104085744.49164-1-thomas@corelatus.se>
References: <20240104085744.49164-1-thomas@corelatus.se>
Subject: Re: [PATCH RESEND net] net: Implement missing SO_TIMESTAMPING_NEW
 cmsg support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Thomas Lange wrote:
> Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
> socket option SO_TIMESTAMPING_NEW. However, it was never implemented in
> __sock_cmsg_send thus breaking SO_TIMESTAMPING cmsg for platforms using
> SO_TIMESTAMPING_NEW.
> 
> Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
> Link: https://lore.kernel.org/netdev/6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com/
> Signed-off-by: Thomas Lange <thomas@corelatus.se>

Reviewed-by: Willem de Bruijn <willemb@google.com>

