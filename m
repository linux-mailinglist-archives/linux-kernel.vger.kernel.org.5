Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A117B7720
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjJDE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjJDE3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:29:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497CAC;
        Tue,  3 Oct 2023 21:29:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c76ef40e84so2718815ad.0;
        Tue, 03 Oct 2023 21:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696393777; x=1696998577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFDTC7TXdF/+8AC2sZgPs2tWlcPzWiDKC/6kkyKRXcQ=;
        b=OJUTlaBP0vjKyRXFn86kmJUfkMkyaAgKqDWyDEh8VHD0JjzLiwD8Ix7BzlAjsYtLLm
         vVabWJXfXUXZAARv8W2kTT5YuFT+amp56wTOAW/U9ZO92xQyor+ScX+gXiRpcAOzVaCz
         ngConrYvu166AzY9sgecTePKfAhIOSYagqIyigDffIm7Df2hIZ1++Ogtw3jxUY44OR8f
         zuy86GBb05iNjWZiNt6/QrtBJfiYeJKxG7F5cCsVURrkjEgf+nukhBtshfvfBU0IF+Gh
         iJgOlIVoClEfZjSOxe4l5tvSYBP5e58Q9hiVgtXu/Ck9ufgZlkAaNHTm7Actxevbgf87
         pRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696393777; x=1696998577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFDTC7TXdF/+8AC2sZgPs2tWlcPzWiDKC/6kkyKRXcQ=;
        b=FOqJlB1WoU0cdhrRyAQEOUUB1W1bL+MMPWhQUm4AuDu2mzKNYWSRnyv4S/LUAzqirH
         mf1qOAADAsCmuX/q6NXWX8Uv3n84A13zByQRVrEXJEgvfBR6B9/LJd+lhYi7u19OVUxA
         RjJBcDBSinm7xoeUjcVO9MIMwDaDMC4dLiJCE3uCgjU8SMnMFH06SZ/DFh4z23jNcPaa
         3kS26m6J3CRyl+YQ20lNEZ9qa1jTKBJEGmFegtFSxLaypKS2OVFOxIIc/CfjuRWYAJPS
         RSwyB5YZGNLebQHux+RNO5ynz94ZDjLNG17tR9n5fPiswf/i40fWJaoKzEvlKaSKQpFc
         1Csw==
X-Gm-Message-State: AOJu0YxtOM2HH1djmbS5I2okg4QNsy9pZ6Ehkv9DoH/bVPr3jw6U58rt
        oiR/NTU6mE2MwGuk/0wuyz0=
X-Google-Smtp-Source: AGHT+IHDxOApt952uQvNNmohjnNzovgk6vz7WIKhrGzRfF8iYSXl98uQ4/hAMrT1ihNVAK5zX3QzMA==
X-Received: by 2002:a17:903:22ce:b0:1bb:83ec:832 with SMTP id y14-20020a17090322ce00b001bb83ec0832mr1526447plg.2.1696393776741;
        Tue, 03 Oct 2023 21:29:36 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id bc8-20020a170902930800b001c73f51e61csm2501874plb.106.2023.10.03.21.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:29:36 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:29:33 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
References: <20231003041701.1745953-1-maheshb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003041701.1745953-1-maheshb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> add support for TS sandwich of the user preferred timebase. The options
> supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
> and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> 
> Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().

NAK

Don't just ignore feedback and repost.
