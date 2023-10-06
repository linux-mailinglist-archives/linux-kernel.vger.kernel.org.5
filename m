Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1AC7BC16F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjJFVo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjJFVoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:44:24 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28195C5;
        Fri,  6 Oct 2023 14:44:23 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c871a095ceso21733375ad.2;
        Fri, 06 Oct 2023 14:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696628662; x=1697233462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIVn4u1yJXE9GPf/dzGUtUFy43rKq970JPbAFojeRKM=;
        b=GUhgDeCK4XjCXTLOVS31AGcu8iyMNkzHaN05W2h2/n4RcNhadyY5F/qndvo1A+lbxZ
         3nUXWIwnv/yh79MzzKS0Pb9Kd2GTwb/ps870ALqmsENhRZvxS0Kw0JoknAqGritcRsFX
         wT3U3oaaW059/ne2hWK3OafJXP32DBL889q/2GMOSIhDRxEvk+vYnaSe26sAxwN85KjR
         PitrKbc3SGCZyIqYRV9vcsLrl0ZC6vy8OkG8jN9JNitBf6T94mXOxU/cIbkOTbdFUiD7
         0I6UkAGIUgDKXtoUVG8c33vINxBADsEBiPUcvv6158j2ymyip9scnwjbzSrfRmAkbw1C
         AjVQ==
X-Gm-Message-State: AOJu0YyZG3kUUa3Z25YKDxhtzBOssq6TCfM4bSuoW6uttSxjhIXgHjbA
        SP2QAQCVNyUpCjga8AOS6Pw=
X-Google-Smtp-Source: AGHT+IFUYU/5tT+wcfbTt7FLR7SeyP5pqtB/vKdWiw5BY+hmbuX8hYUXNJeVPi7le5S0sbJt7bwJAQ==
X-Received: by 2002:a17:902:dac8:b0:1bf:22b7:86d with SMTP id q8-20020a170902dac800b001bf22b7086dmr10846553plx.3.1696628662557;
        Fri, 06 Oct 2023 14:44:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001adf6b21c77sm4428040plg.107.2023.10.06.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 14:44:21 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:44:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ian Campbell <Ian.Campbell@citrix.com>,
        Ben Hutchings <bhutchings@solarflare.com>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Subject: Re: [PATCH] xen-netback: use default TX queue size for vifs
Message-ID: <ZSB/tKydP056arIy@liuwe-devbox-debian-v2>
References: <20231005140831.89117-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005140831.89117-1-roger.pau@citrix.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:08:31PM +0200, Roger Pau Monne wrote:
> Do not set netback interfaces (vifs) default TX queue size to the ring size.
> The TX queue size is not related to the ring size, and using the ring size (32)
> as the queue size can lead to packet drops.  Note the TX side of the vif
> interface in the netback domain is the one receiving packets to be injected
> to the guest.
> 
> Do not explicitly set the TX queue length to any value when creating the
> interface, and instead use the system default.  Note that the queue length can
> also be adjusted at runtime.
> 
> Fixes: f942dc2552b8 ('xen network backend driver')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
