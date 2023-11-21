Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243627F37CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKUVBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:01:47 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35AC1A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:01:43 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da077db5145so5568398276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700600503; x=1701205303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0Mtot4o4Iv50p8GRxRR7oxPOP/8FQ0rT3lW5lbuUPw=;
        b=mIQkeTVNt1mdhwm3zoA2sJz0xAwwQeRKKz09vJod5/Fuw5SOTDcdKzNVm7GmZ2qyar
         PRwzI4bs7UmFX4w0LOV6renVazu2QJQcYIdifsSXVHxECSZDKQTmSvITduEZe6oqj3EU
         /37tkWEH2UCThcjVjFUqf83lbL2m3hHQ9Y0bup7mZTSpd9ecPk43yTLcULOOiiwLSRvx
         kwKHGpyOLTxpi2sbd24dnCsUsqE7/PVyVmmadrmT9r1O+6aSPXKSwKKjNg6W1ca10kJj
         msTM1rKHp73CRJi+co8MUqhg2cXziRbJuIAfuVfe842yJbkEEWtslvDejpB/5Vna+YyQ
         SoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700600503; x=1701205303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Mtot4o4Iv50p8GRxRR7oxPOP/8FQ0rT3lW5lbuUPw=;
        b=aUh8bsZRWB/0QJVEEZgdo4a1zVMXccKNR9P5YtzBnNSycxVCgbm8bD41Gj19hdwRgJ
         cHRdcdHBBm5GPdl1Ee51+Q+zRb9ckzm4vTfqkNx+Phn0rVa1sBzGKPcIFSxAMgiRAGth
         wCw3kdf1zPmm4yRDjG4mmRYMzQIhyyFiKJk0C914eIJZKmGBiyJYhwSqJlMz9QUOvxSR
         SO7OXRvLV6in1f1Q+EcNcN3hvBwP9dZOZT04S/BuGjKUKSOr9HPxuhR6KkYHxcqwwSS3
         ar2LwoLXQnkxHIVrxZet9cRK6wtaMuZuNnAmbRxnYGtW9FNfKGAdkTWuePk3BDC0IDLN
         dneA==
X-Gm-Message-State: AOJu0YzV8bXEAsMyysUymv9d9YM18SQwHC1/jCPTZlltAsWnZzoHUrGV
        kGMyTz3/rVNbAPbYPKyxaYjZxA==
X-Google-Smtp-Source: AGHT+IEHLwu5bZxVyWPESADsP4NWmSI7NnvdTQNabAOLg5JOWUP+SZt4Lrcs9tIEgRerSnc77E9Aig==
X-Received: by 2002:a25:e797:0:b0:da0:37c8:9f00 with SMTP id e145-20020a25e797000000b00da037c89f00mr164010ybh.36.1700600502794;
        Tue, 21 Nov 2023 13:01:42 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m204-20020a2558d5000000b00da07d9e47b4sm939035ybb.55.2023.11.21.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:01:42 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:01:41 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 0/5] btrfs: zoned: remove extent_buffer redirtying
Message-ID: <20231121210141.GB1675377@perftesting>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:32:29AM -0800, Johannes Thumshirn wrote:
> Since the beginning of zoned mode, I've promised Josef to get rid of the
> extent_buffer redirtying, but never actually got around to doing so.
> 
> Then 2 weeks ago our CI has hit an ASSERT() in this area and I started to look
> into it again. After some discussion with Christoph we came to the conclusion
> to finally take the time and get rid of the extent_buffer redirtying once and
> for all.
> 
> Patch one renames EXTENT_BUFFER_NO_CHECK into EXTENT_BUFFER_CANCELLED, because
> this fits the new model somewhat better.
> 
> Number two sets the cancel bit instead of clearing the dirty bit from a zoned
> extent_buffer.
> 
> Number three removes the last remaining bits of btrfs_redirty_list_add().
> 
> The last two patches in this series are just trivial cleanups I came across
> while looking at the code.
>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 
