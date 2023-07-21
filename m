Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C975D656
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGUVRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52715123
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689974222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2CksioBG3mjJvGCQonqr0ZBTYtGb80XcIh5ZZevVPE=;
        b=WJZOWjc38hoqFBZpGRBQQ7aktWEQ1G09798JhDathnvZ1L0clGgEW/xx3eZTtNKWFF58P6
        mw0lN5/frYknHzsSkpU4jIHUL5RDIEnig9Am2ZdFBWwtbl/VC0XDAR6xHfP4Ac2DiwsPyQ
        NTWP/MEa/1gP5r2ohfGZiDxc1RkNjB0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-AnRe21FcMPinzgSjJ20LJg-1; Fri, 21 Jul 2023 17:17:00 -0400
X-MC-Unique: AnRe21FcMPinzgSjJ20LJg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cd05c0415so28531066d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689974220; x=1690579020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2CksioBG3mjJvGCQonqr0ZBTYtGb80XcIh5ZZevVPE=;
        b=CxlJ6DwUgi683IwOOjRoJaUZwxsA2Ig2p0bK2BBF1y3O3ArOiNTHmBPH1UciatbgiQ
         q7FkGfls/Rkso+dTrlqhqKH7/xsTWtznVXzv+kYVokg3Ar/G+b77GP7oka4gaj5BnGZG
         /K6DQxW0Q12fHMb4TKUItWKpt6V/HrG6bsaEr2vEI021oq2Hm8Ia6xiO69I1FR6c0dfg
         iGcrdcKj26JZYj5yqFOz9RExRxEZiLOfXtVwQ6jaa1G5HfqL9sSCUNfqaoSSAoo/EgGy
         oZDhOwht8C35uIIXQY/k/fbvLNfm0UjzMhkxSAYdByUy1L/suZH1sQAE3JtTGjCIVih5
         AS7Q==
X-Gm-Message-State: ABy/qLa2fLRV2fEQ0mUoD+94Dato8dNbM8IqwGaQa1YjEKT9gkj2Jm4u
        RSfuIvV2K0zMsZpnd6PDBUpDqfFsBF3m3cW7AAo+nFR/PXxiOtIL91gj9hp3J1S4w2gd44XUJ2X
        yF/GIph65/lnV/9/2IOUI9GUO
X-Received: by 2002:a0c:ecd0:0:b0:636:10ce:5203 with SMTP id o16-20020a0cecd0000000b0063610ce5203mr1192001qvq.38.1689974220352;
        Fri, 21 Jul 2023 14:17:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFi7MLn42ck7e1zCs2zr7hOu0xs9e+zv2wIO06MPZbmJ0CwqyqfAea4op3hSNeC6hTYu/bcmQ==
X-Received: by 2002:a0c:ecd0:0:b0:636:10ce:5203 with SMTP id o16-20020a0cecd0000000b0063610ce5203mr1191990qvq.38.1689974220164;
        Fri, 21 Jul 2023 14:17:00 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id u4-20020a0cf1c4000000b006375f9fd170sm1578237qvl.34.2023.07.21.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 14:16:59 -0700 (PDT)
Date:   Fri, 21 Jul 2023 16:16:57 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: lpass: Log clk_get() failures
Message-ID: <pwfv6pbyggvbrs45v52qb4hmjrmdr7ngclhxw2gvlz34xuto2d@pnw3tmk2imlr>
References: <20230721165027.2155528-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721165027.2155528-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:50:27AM -0700, Bjorn Andersson wrote:
> The LPASS macro drivers all acquire a number of clocks, but give no
> indication when clk_get() fails, making it hard to identify and debug
> system configuration issues.  Make these drivers provide useful debug
> information when this happens.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

