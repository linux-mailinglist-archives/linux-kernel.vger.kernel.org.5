Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160617DCDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbjJaN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344548AbjJaN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4835E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698758808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eI/NB+UK7wm+ikX7wMjjd1LtGrSm/qZ7Qv6AHobbkPs=;
        b=hpUfFZKARRkCLpjWMlxRttLcYrMRYNxZsMflA2YWlO//3xRtLIb2TsSykVZRLIX3YMSSdp
        Kf7wwNAFgoWWOJma991VFYi+UFhfqmnv5lH0p9+1NnbMDEqSeLJeFBVuc6VIEQkdpatokZ
        jafEQJ08HMS/wKbDcvwj3CkQ/GpTfjc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-9H31QRpbPG6glCdLzZtsBw-1; Tue, 31 Oct 2023 09:26:47 -0400
X-MC-Unique: 9H31QRpbPG6glCdLzZtsBw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41ce372d248so69920141cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758806; x=1699363606;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI/NB+UK7wm+ikX7wMjjd1LtGrSm/qZ7Qv6AHobbkPs=;
        b=vpnSVxAaCM58mLDR48VlUeW99UcFvPKK0l0b/b1Q4VYjQrLfpvQfwxLDxo6wOOmsK7
         fjcAKfcjQYgiT9JL4IsM/Rsw8U9foZb0drUasixUdFe7MtkeK3yTowfRqtDLBQQfa6i0
         n4COQQt5CQyLu/KqH7aUiCrz56vz3M6WZGsy0uVRsVwsyOhlEmBK/uhRvdkgYlnd78Gs
         49WnMSDkiub+zDch8nDaL7wosljJRTHMOKm2/fTVP78DAiCHJc+Y3Wk9WnYSCU6sPwhv
         ovZ3rddb6JiM9E/gFnCtss1rHmVj8dx8QHBi5B6lsiYgnY1w6VFRT5Of8pQ7XSmRGpbe
         6OzA==
X-Gm-Message-State: AOJu0YzEdnJkgB1WKCajL3b1PlZK1utzI/jpMu+gU5nlIFD0ocx4nn6n
        cXRWDBhW7C5D1PBjWe0Ub+UFp4CZID/XkBZBd/zSF8bVQRyVGz1zOq2O7kdTtyCVsKxGr3qVQii
        Ufu+UJ37URRdqksq5ZH7iFGpS
X-Received: by 2002:ac8:5c07:0:b0:412:395c:e794 with SMTP id i7-20020ac85c07000000b00412395ce794mr16506850qti.50.1698758806643;
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJ+JdW34kAi/vPRSUYYZ/SunG5KPuPwv6RMEn5yGHPjewye+0V9zLeMALeZ3Oa1GIJGE7BQ==
X-Received: by 2002:ac8:5c07:0:b0:412:395c:e794 with SMTP id i7-20020ac85c07000000b00412395ce794mr16506834qti.50.1698758806379;
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id w26-20020ac84d1a000000b00405502aaf76sm492115qtv.57.2023.10.31.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
Date:   Tue, 31 Oct 2023 09:26:44 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
 <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since you wrote the same function verbatim in 3 different files, I
> think it would be better place it in separate, new, net_helper.sh file
> and include such file from the various callers. Possibly additionally
> rename the function as wait_local_udp_port_listen.
>
Thanks, I'll move it over. I think it would be best though to leave udp
out of the name and to just pass the protocol as an argument. That way
any future tcp tests can also take advantage of it.

Lucas

