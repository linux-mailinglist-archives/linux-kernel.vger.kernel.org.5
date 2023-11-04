Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C119D7E0D42
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377967AbjKDCNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345347AbjKDCNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:13:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD460FB;
        Fri,  3 Nov 2023 19:13:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2802a827723so628190a91.0;
        Fri, 03 Nov 2023 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699064014; x=1699668814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sfu5H2gIHMm+FuVOEUDHCowHZHcLpATyC/dqd6vTeY=;
        b=CQvlhnpYxkeRcnlBCVcKPDdDLsXznIUDR6GY9b9ThvOE40VCP5J9dXg2vlmfL04stz
         ihbWn6LoBVD/ay0AbbKn8P2eY2RAeP0c2Tdt7hogF/5uoAmZu0h/OE1+6sZ7Z5h7mAuF
         MMcjy/eRDU2R51ZeG4mNDi6gzs3pbsSHcmOgJN6vgBEybwvtwRODAA0TAJii72YlV8W1
         ZkMx9LYv9d40SD6mY9++oqWy0Gx2nQ0gZGtEpUrsvTWyZ15BI86mzrtCX8HdjFeYUHeB
         ewelKv07OpWuWVC6H+Q8hyMPjxALX+s8658dwAkZeZDM9Am+MRKy7gZUIh9E8TBUFvmU
         eD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699064014; x=1699668814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Sfu5H2gIHMm+FuVOEUDHCowHZHcLpATyC/dqd6vTeY=;
        b=gpiLZ8K8lnzps3jcI47w5T6LJ8JqjTbSft/C9w1px0J61iqbuYrWm2bRZvqs3cOTe8
         8SZ1vfHKvrPVuJ/waXBOEkl67yCFDO1yVXzlTtkIDSmgtOqVTGlEvjoqM1WxRdpFYPlm
         se/dC3Fa3RT4yo1lJsBeooKwiBUbZxYZINcbI37MbquCu95SQD25AIkdLIba+AoXXpVB
         wLtvlWA8pyj2cybFrqs4DxxIZTzA7q1O9pNt217pCo71jUWquNLkOmG1Kizb4yg4cBFT
         WHttT0K3/Oj6xbR74S2bFMNZJA5tkrkKA/jeHWYlwWSqqbsbvJCbr9ISZo6UnYCTfUnO
         DYCA==
X-Gm-Message-State: AOJu0YzAAKaB/XrVN5aizU3JMbHamQIDJIzWLpl/4nUP5NFXJdh+y58w
        ciNauMS3qRS6NWha9s7XtUQ=
X-Google-Smtp-Source: AGHT+IH6LveAMZoUcTKeRcFDzWw5I98IUX9rItE2te8tDOMyNtRwIXOMx5MB4nzfP77rfkjeHQddCQ==
X-Received: by 2002:a17:903:32d2:b0:1cc:32c6:e5fa with SMTP id i18-20020a17090332d200b001cc32c6e5famr19777710plr.6.1699064014319;
        Fri, 03 Nov 2023 19:13:34 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001cc436e9806sm1976501plx.81.2023.11.03.19.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 19:13:33 -0700 (PDT)
Date:   Fri, 3 Nov 2023 19:13:31 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Edward Adam Davis <eadavis@qq.com>, habetsm.xilinx@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUWoyxIgl6vDFsjp@hoboy.vegasvil.org>
References: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
 <ZUPnlsm91R72MBs7@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUPnlsm91R72MBs7@dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 02:16:54PM -0400, Jeremy Cline wrote:

> While this patch looks to cover adding and removing items from the list,
> the code that iterates over the list isn't covered which can be
> problematic. If the list is modified while it is being iterated, the
> iterating code could chase an invalid pointer.

Indeed.

See ptp_clock.c:

 416         case PTP_CLOCK_EXTTS:
 417                 /* Enqueue timestamp on selected queues */
 418                 list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
 419                         if (test_bit((unsigned int)event->index, tsevq->mask))
 420                                 enqueue_external_timestamp(tsevq, event);
 421                 }
 422                 wake_up_interruptible(&ptp->tsev_wq);
 423                 break;

Thanks,
Richard
