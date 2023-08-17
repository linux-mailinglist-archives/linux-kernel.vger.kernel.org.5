Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2C7801C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356160AbjHQXlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356203AbjHQXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615F10C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692315643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTrEHxr3/rgVj2kGdngCSyXx3bBs8bGQLPtNlGAFwQo=;
        b=ZeYno9DxYarPGW9213naJRQAbvr4e0xzrU7YuqnmAUdq3efGOnyZ6SXKlOviI0oqh99nT+
        Uuz0QZZlXAUzM7oE/a64vLXwUSGwBfaTmh2P4H2uTqd+kmKgjVnEMEwP0/UO70d0TSJLqL
        K889hp3U8VLeEIKAdXlxiY7jlniwX/k=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-AFerOAhdPjqNTfkX7HhIqw-1; Thu, 17 Aug 2023 19:40:42 -0400
X-MC-Unique: AFerOAhdPjqNTfkX7HhIqw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a337ddff03so355832b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315642; x=1692920442;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTrEHxr3/rgVj2kGdngCSyXx3bBs8bGQLPtNlGAFwQo=;
        b=dYWNjVBGLCZ8SRfur9HNsmMxHeVFZFeatb4FuXwftpZqrRFYgZketKFHuBDQW1heXc
         WfLd7iz1UVOSWq9xc417nwim3CAzESqYBvOTizPMtPeElGHzsSHt10BNlOhMTna7ocjQ
         W/DfrJLpRW3faQm4vIjCc+8JndwA3KfSTpn0Mw7d83WHabCZPHTvl9SKwC6y9NVReuJy
         bFJx3EDEm64bHIrZ7h10eOwJhsX8iGBHKWJh8bAf2LnN3x+KBG8spRgyXsdLzaPv3ZAn
         Qzted4ReGWylqIy2S4gQBCCs2aooVNa0cgUFOaquXrzO//PV+K7Mmf3vZqaoDP8DVcz4
         R4+w==
X-Gm-Message-State: AOJu0YyMZdpShNkEUYxkr58O8Y1Tlo6ELkOLQ0cLPPOlAZWpTHn9mgrU
        x0pcGmBTqnHAEchQ3TGLr7saY7IdnUmmpFO73srtLIurOSgkgoFviKmmjd+XhmrLSLqmB1mRg8p
        q8Zp70wROVzmNFUJaYvbGmKzi
X-Received: by 2002:a05:6359:6488:b0:137:d0bb:6036 with SMTP id si8-20020a056359648800b00137d0bb6036mr876978rwb.1.1692315640624;
        Thu, 17 Aug 2023 16:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSpQRAsPuI44RrFwg+S7bPclSIqpChEbOCQg9NW5JdfvILfiZ4CVPLZpkM/MouwdijF/sKIQ==
X-Received: by 2002:a05:6359:6488:b0:137:d0bb:6036 with SMTP id si8-20020a056359648800b00137d0bb6036mr876933rwb.1.1692315638875;
        Thu, 17 Aug 2023 16:40:38 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y5-20020a0dd605000000b0054bfc94a10dsm181134ywd.47.2023.08.17.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:40:38 -0700 (PDT)
Date:   Thu, 17 Aug 2023 19:40:36 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: nvmem-reboot-mode: quiet some device
 deferrals
Message-ID: <ZN6v9I0YPiiqcaTo@brian-x1>
References: <20230817214218.638846-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817214218.638846-1-ahalaney@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:41:57PM -0500, Andrew Halaney wrote:
> Some errors are being logged that are really due to deferrals,
> which is confusing to users. Use dev_err_probe() to handle when to log
> at error level versus debug. This also has the added bonuses of logging
> to devices_deferred and printing the error value.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>
Tested-by: Brian Masney <bmasney@redhat.com>

