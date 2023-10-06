Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03707BB8DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjJFNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjJFNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:15:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4B2EB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:15:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4060b623e64so13340395e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1696598149; x=1697202949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u3No+tEtAczGHwk0FS59fcQbsVL06vZXyJIYRaE8Tk=;
        b=HSN6NSDfHuPUIZABk6fniy+XCebR6Ky0HHEPfDyGFE4qZsFzQhRLUDULIzTPuzZWRm
         AqvpfHapEnEkzdZJyJiARXgNfioa7eupWS/4wpXtIdPoDwYhTOtJKgg7zjeq1qXzTh+b
         QLBNctw8fRIePWnduK/phja/gRANMU3B5sEbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696598149; x=1697202949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u3No+tEtAczGHwk0FS59fcQbsVL06vZXyJIYRaE8Tk=;
        b=nbUWgJvO7FHg1qG1AcU/IfNmqaY4awYouuTRJmpNFpYkx4Qm7v9ojFBG9Y2BzMQQqQ
         CKU053561OhXMA8TG8K1V6NSEi0VbtWuaijB9D6o7k+BePobATzVuvJo6Jaq/YaMhEuO
         Upa4nKDyJbQhx0u0TCe+ZnY+Chdepb5XULeOpFjeeGeipqUIMZPwJgRKKEJcOKZ0zoQ5
         M9vzQ5zMwvjPo0FOT+SOkpmfurLmdEvMPcIRZKRehOgqiO58hRB+t+ujjWKwnSnzobeG
         aiTIvIgzR3ILZL0iUP6L4v33PDn6zLcB0SfmwqRh6B/saloiPiLl3N40QyiMBV2kKEMJ
         Fdqw==
X-Gm-Message-State: AOJu0Yz5xcer+N9vLeuE6thk3oNLZCOIcj1JO4hfs7eEB1RNrpGi3PP6
        vKW7zopivgMfhLR750/MHYeG8Un1uWRTKUyvfQ7k
X-Google-Smtp-Source: AGHT+IEhVvOcQOtLTbsHnMfSpeq7GltoUpxG99Rgayd8nZ8RlSHyh7d1e0syV2RPhnErDHz48fOjez/pJ/HH9GmkPGM=
X-Received: by 2002:a05:600c:3795:b0:401:b92f:eec5 with SMTP id
 o21-20020a05600c379500b00401b92feec5mr4056905wmr.9.1696598149645; Fri, 06 Oct
 2023 06:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231005140831.89117-1-roger.pau@citrix.com>
In-Reply-To: <20231005140831.89117-1-roger.pau@citrix.com>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Date:   Fri, 6 Oct 2023 14:15:38 +0100
Message-ID: <CAG7k0Er8cVKHF2NwogmXtuN57iYb0rGoQH4aZgg7boy2Hv4-fw@mail.gmail.com>
Subject: Re: [PATCH] xen-netback: use default TX queue size for vifs
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ian Campbell <Ian.Campbell@citrix.com>,
        Ben Hutchings <bhutchings@solarflare.com>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 3:08=E2=80=AFPM Roger Pau Monne <roger.pau@citrix.co=
m> wrote:
>
> Do not set netback interfaces (vifs) default TX queue size to the ring si=
ze.
> The TX queue size is not related to the ring size, and using the ring siz=
e (32)
> as the queue size can lead to packet drops.  Note the TX side of the vif
> interface in the netback domain is the one receiving packets to be inject=
ed
> to the guest.
>
> Do not explicitly set the TX queue length to any value when creating the
> interface, and instead use the system default.  Note that the queue lengt=
h can
> also be adjusted at runtime.
>
> Fixes: f942dc2552b8 ('xen network backend driver')
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---

Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
