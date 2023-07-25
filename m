Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F97620E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGYSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjGYSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:02:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3230D4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:02:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666ecb21f86so5414724b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690308145; x=1690912945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJTt2U2NuYtpqmPO/E5rksGZKFxR7080PvQ9rfNEIT0=;
        b=H/qnT/zw1ZKVvhIiti7ZrJ+CKY+nsUd44Feco3JrcTkPoLxHbTWCy+DKloAYqMmTio
         Avc3dGMwLesRB6AVUHLvnFZgor5wkSCKUJiS1XaOiGmgNM8txnxvRlIJBlZ+JfRQA2ty
         dUlLPLUbDzcU8q4mPlwga2kLHoA8DjudKKeZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308145; x=1690912945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJTt2U2NuYtpqmPO/E5rksGZKFxR7080PvQ9rfNEIT0=;
        b=CDKl29Gmh2b50DF1SaeqvfP4on9yliMeIuRom+tXFRrvygWLSCkcKSTwh1CCk0NUMF
         zaEZi/5TsyfV8fSUP4s4WL9obPTHxuMuG7zu+AXsoSckkwhA19RMISV0jVDTEcf179eE
         ji3AbKyUgeMtZsc7M/sOsTX7qqkI2nR/HzUSUB+s2bMzH/DEs1aIFtEaeuURNubrCXol
         DSn51FMuh9UJPitRxPLL/WB18cbbrxVX3gJtYqfIPtIjZuu5PfpW76gRMtrJ583DvTq/
         Ho7RXbsYIQk/Levko10ld3pnwq8ql9pOfZ3362a1f7nch115XbUAsHzcHGUGoBaEeaTS
         oIHw==
X-Gm-Message-State: ABy/qLbjhju0+P2qZeYw4qhbUrj+oRWmaimH2ThUWhPuba2osm3UrVZS
        rMb9xWdHR9IRQumYLQmCf/8r/Q==
X-Google-Smtp-Source: APBJJlEtWFJjHJDboJs2iGOz7uvLuND1BXld8s+/cHW/jI+TQLfaHXNNsGMxRqHO6aVqnR6rsNX4KA==
X-Received: by 2002:a05:6a00:808:b0:667:e17e:85b7 with SMTP id m8-20020a056a00080800b00667e17e85b7mr30804pfk.1.1690308144887;
        Tue, 25 Jul 2023 11:02:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b0f8:d2f9:1ff0:6ef])
        by smtp.gmail.com with ESMTPSA id i8-20020aa78d88000000b006765cb32558sm9909073pfr.139.2023.07.25.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:02:24 -0700 (PDT)
Date:   Tue, 25 Jul 2023 11:02:21 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        coreboot@coreboot.org, Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] firmware: coreboot: framebuffer: Allow building with
 simpledrm
Message-ID: <ZMAOLQWrRttRgpoP@google.com>
References: <20230725174334.887485-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725174334.887485-1-alpernebiyasak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(administrative note: I doubt coreboot@coreboot.org is interested in
receiving linux kernel driver patches)

On Tue, Jul 25, 2023 at 08:43:33PM +0300, Alper Nebi Yasak wrote:
> The coreboot framebuffer driver registers a "simple-framebuffer" device
> based on the information from the firmware, after checking that it's
> compatible with the formats listed in simplefb.h. It was added before
> simpledrm, and its Kconfig marked as dependent on the simplefb driver.
> 
> The simpledrm driver can also handle "simple-framebuffer" devices and
> the coreboot framebuffer works fine with it on a 'Lick' Chromebook.
> Allow building the coreboot framebuffer driver with simpledrm as well.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>
