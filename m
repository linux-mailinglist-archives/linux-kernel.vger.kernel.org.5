Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1061A7B0542
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjI0NWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjI0NWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:22:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53760126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:22:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32164a6af64so9660799f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695820936; x=1696425736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4t8SMIb+aaRBITzGumRvFCVICUhpBpI6WIpWYOA324=;
        b=q5NF3y+/iqeB3YgWYyO+wtFahg+N8huzD1NlX/bqD//GXmfAtNm9XUiXrj0pZyL8NZ
         6E/EyRp7JNrLnIrMQq0hMME2aNh72bRc2dqlUqqSYKpds0ZzbjjX/DunNzGFqcTZdWm8
         NSpitxVbPrpH1UjOXr1lCNbCOors7/pmpFybhKApblLFqwWyYm7LaGSDA3OzrwsZ1BiR
         e7HSXg2qMrblkSf5Ab/DhKv5jJ4zMaS7Cw24wT6xGs60lhVqBMIEl1Gl83F2qpPvpoNb
         9V8n8mnf8DtC+8nZon5CM2pVVYDvlG1H8czq0tMQdtZiszrHghR07hkj/axOy4uFReh3
         K8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820936; x=1696425736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4t8SMIb+aaRBITzGumRvFCVICUhpBpI6WIpWYOA324=;
        b=QkJuPPDSDrLASW24AUvnSTzgM1BgMuIDkB/YiWKsk8uDgRLfZgFWDQT6cQm+Nt6gmR
         jFeTEWoJUXcOzCVkxw7EhBtWi1qe9Xy2t8xOoZmn3gKe8r9mGDXUdo9Zqs8UAnbppAPX
         v5692rOIJcyX1MRkvY2Bb+RMIKPYqF++kZFwWhYiijHMAhwxWvZGmvcQx1n0KEvY2ETb
         dVT59XowlPjrjHV3z6QnY4mj9dCtLUZmI6qWTH03GDvYCE+HIbf12lMYzbCH2/caoXz9
         KmZnw0NYr/ITIrz5Kxafn9C9JnMoThwepaBAlKsIWllMFjYEbuX4BOh1ZgF9k+5l9qvt
         UnmA==
X-Gm-Message-State: AOJu0YyzFlEe2CVVEZ1063hlYCMGMhGeFApC6PJSz0jPDUSmEpmnScJW
        c9UN/CPu3OW8AY6imwxkp/4/TA==
X-Google-Smtp-Source: AGHT+IFqrcn5hr4kRIJXh34PCTleWf76T9zn8n1G+X6t7JwnKWOk356wLHy7eTKPvvtXc9qvv9gXFw==
X-Received: by 2002:a5d:6388:0:b0:321:3c37:ec81 with SMTP id p8-20020a5d6388000000b003213c37ec81mr1765749wru.10.1695820935706;
        Wed, 27 Sep 2023 06:22:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d29-20020adfa41d000000b003197869bcd7sm12045469wra.13.2023.09.27.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:22:15 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:22:10 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com, arnd@arndb.de,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru,
        harshit.m.mogalapalli@oracle.com, liweilei@awinic.com,
        yang.lee@linux.alibaba.com, u.kleine-koenig@pengutronix.de,
        yijiangtao@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 6/8] ASoC: codecs: Modify the code related to the
 property
Message-ID: <ce82d523-dc8a-4d04-8762-6cc6d5d3478a@kadam.mountain>
References: <20230927121634.94822-1-wangweidong.a@awinic.com>
 <20230927121634.94822-7-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927121634.94822-7-wangweidong.a@awinic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 08:16:32PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Change "sound-channel" to "awinic,audio-channel".

I'm not super happy that we are doing part of the sound-channel rename
as part of this patch instead of all at once in the same patch.

> Change "aw88261_smartpa" to "aw88261".
> Change "sync-flag" to "awinic,sync-flag".
> These changes are made to align with yaml files.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>

regards,
dan carpenter

