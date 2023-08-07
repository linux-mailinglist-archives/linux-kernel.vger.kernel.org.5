Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D777315A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHGVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHGVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C510C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691444346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4s0Kw+c/F9UtXftYXYaWtU9eJKPG9T0A3yU/7K9uITw=;
        b=SeUbR82N7WxqMO/Va/lxZMP2QTrX07n1mwtdFiWBKQkk7zYIMZBGm1ErKSKC2YrsJasJM5
        raQiQKBbqPJy/hflBZGbclF1G8tcalgsGWzOytcULjM1BPXubbW5wCTZp0DT7KbxrlC+Gs
        tEz0iRCFJ0mA+RwWBHYQ8VSEq0UCpOs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-o47XY7FaNRKaSsCuyF0y-g-1; Mon, 07 Aug 2023 17:39:05 -0400
X-MC-Unique: o47XY7FaNRKaSsCuyF0y-g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40831789e55so61430221cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444344; x=1692049144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s0Kw+c/F9UtXftYXYaWtU9eJKPG9T0A3yU/7K9uITw=;
        b=dxnDADdwEeonj7+pw7s5qVRAYUEg083+PiNGD99BmrlLyBTWDBCq5MfgpmHlKORd0w
         E+EmeN30NCzZKQJcLMuWSbt7mtu21ymZxkuwc76AIMKEcvXJ0ZKuBBVUaQZF0TEEc9J/
         WT5qzz+NKcfZaZPkOH8fSUxJxe8MlHuyPXN0myyOCj9FuqzdBhSUUdb/9X3V9yEUnb5M
         zd2HQKiEEKrJlf0w+5c0f+GAZxMJKx5wFA6cMf3IGyIf9SUQnreElnL75pGmclArQuQX
         rfjTnxCQ6ymYE8jIQnmrDqY0G/adAdkBRTQIrGQ4LQypdo6nhzNTm4tpkrD4wliVG29m
         773A==
X-Gm-Message-State: AOJu0YxAUs7b95JItWocrwDnIPenzlJcMKzKVhwo3HgIR4OykJTmhJGD
        Fi7viebt1LH+3NqqxQwoZmpYNri1m441Ojl9SxuYhOR2EnIlmAOJ3jTJnw3sjIqLGb7FZiwbVv+
        zDkhuLlaCNu4Ud0oCve23wkQHMbMRblib
X-Received: by 2002:a05:622a:181d:b0:405:56bb:343b with SMTP id t29-20020a05622a181d00b0040556bb343bmr13385089qtc.41.1691444344369;
        Mon, 07 Aug 2023 14:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZpV2xc1KEBl5NM0N+gFp8G7X0ze4YFLSxvaNIXK7YS+wUiw1yPsPPpwWdI7eh5WPCHibnfw==
X-Received: by 2002:a05:622a:181d:b0:405:56bb:343b with SMTP id t29-20020a05622a181d00b0040556bb343bmr13385075qtc.41.1691444344061;
        Mon, 07 Aug 2023 14:39:04 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id a7-20020ac844a7000000b0040ff0e520besm2953727qto.35.2023.08.07.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:39:03 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:39:01 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sa8775p: add a node for the second
 serdes PHY
Message-ID: <ann5dn236wyjoz2v3lmvihh2f5ses7nwy7lpqlkpoxvpcxgbjp@7ys6bkodptek>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-2-brgl@bgdev.pl>
 <qdagbipfnukpsn5a7f6hswbktrwutizluf3zom2gq6q4q6w6df@h4lkoi3mjzes>
 <b5e30baf-4cf4-4a7f-aa2f-348de843226f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e30baf-4cf4-4a7f-aa2f-348de843226f@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:28:15PM +0200, Andrew Lunn wrote:
> On Mon, Aug 07, 2023 at 04:10:34PM -0500, Andrew Halaney wrote:
> > On Mon, Aug 07, 2023 at 09:34:59PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > 
> > > Add a node for the SerDes PHY used by EMAC1 on sa8775p-ride.
> > > 
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > FWIW this seems to match downstream sources.
> > 
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> 
> Why does matching downstream make it correct and deserve a
> Reviewed-by?
> 
> Did you actually review the change?
> 
>     Andrew
> 

That wording of "match downstream sources" is amiguous, sorry.

What I meant was that:

    1. This looks like a properly formatted dtsi node, follows
       conventions in the file for ordering, etc
    2. The downstream devicetree from Qualcomm uses the same MMIO region
       same dependencies for clocks, etc. I do not have documentation
       to further review past that

I didn't suspect anyone else would cross check this information, so I
did and thought it deserves a RB after that. Please let me know if you'd
rather I just leave a comment saying such without any formal tags (but I
thought since the whole patch looks proper and that information looks
correct compared to the "documentation" I have access to it deserved
such).

In the rest of this series review I may have used similar phrasing with
respect to downstream, but that expanded description is what I meant in
those cases as well.

Thanks,
Andrew

