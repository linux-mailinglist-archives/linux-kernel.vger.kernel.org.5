Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8F782F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjHURJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHURJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:09:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB5ED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:09:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so592a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692637766; x=1693242566;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmaGlr5n+2DXGgBrv/d/BMjY1Qwr5KQiwbBZ6/ICYm4=;
        b=VOqqhj4bQ7xJ2QGJ1hIv2CeUw9gp1I1ELvvL0oRfiD+MBCnZPeec1M4pYSumtNEmEW
         +cmrHXk8DQsHiebY2j57KbxXGrRrWS8lwH0XSnld/EykuPtjkGUjOqyFntGUnpf60V5o
         hZCnCzNY0eT5+MSVroagni1Dwqd4U+sKQ3aenzUZOBdyuX2fai6IFV+qz8IqyyVFatQ+
         dhWr4zXQJr2uCr1RlwBqcf1jFLHHZI02+dq7lE7b+JlvhAntz6A64Sj3yU1dszIJ73lg
         r1Shj3xMw8lJpv2D3fB8ZMAillFR2zqOK+dkV0xRYKr5zJEtAF9fqp5yvVLu+Ordp/3L
         Mvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637766; x=1693242566;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmaGlr5n+2DXGgBrv/d/BMjY1Qwr5KQiwbBZ6/ICYm4=;
        b=LJLE0zuqZ+hK5TNTlEsFNSw0RZ0vXgK0szEOw3/LbWMxrx2yQvh/n3HeEWhjodRMfy
         V1rntmDPsquvRnK0Hmna4j4Ap03ulSb1m8VOIqhJEYBrgk0ZdaKQjolc+sllzY9zIODT
         18M1mvHAqf6eIrz3BVxUjTDY94axSyzlJOTxgV2pATHItDnv/e3blTLBST5fp1hlwuSq
         /3XlgVgQair+27sbIyCOjk5nNeHt1yv5IU1ODarDQYQJ4YDrddx6FbWejlAi/PYdeBRI
         fXhtvbv9Dszuda3FSW5zI2hg4fqCx0CUN5ApIbkCEZu/sGMpxE7wnAbWUOUFRo/AtUz5
         sktA==
X-Gm-Message-State: AOJu0YyswOj8YfwHNMk9eQRHhvsb9hvRCCrgJ/xT/7e1Oahiw1GsbhMX
        C0hKapz4Pfi5yjs3sxId/eFt14RQXMbheZ/1v5PzCQ==
X-Received: by 2002:a50:9311:0:b0:519:7d2:e256 with SMTP id
 m17-20020a509311000000b0051907d2e256mt15355eda.0.1692637765828; Mon, 21 Aug
 2023 10:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230731165926.1815338-1-rdbabiera@google.com>
In-Reply-To: <20230731165926.1815338-1-rdbabiera@google.com>
From:   RD Babiera <rdbabiera@google.com>
Date:   Mon, 21 Aug 2023 10:09:14 -0700
Message-ID: <CALzBnUFH=eQmhdpkt5_czKsZ22=u6yDoZZ0TX4eJkHGbjLANAw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: set initial svdm version based on pd revision
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, kyletso@google.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just wanted to ping this patch for review in case it got lost/forgotten about.

---
Thanks in advance,
rd
