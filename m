Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF06F7E2CDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKFTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjKFTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A1098
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699299094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ASFf3jj0lazzOKnHJ/q3yO4maXPHk8gbLkUqNytOQ6xTG2dufg00/+F0u9inNM9APzRo/5
        SElMhLm5CFMQsfDPQ8k7INcQ8V+fEBBVSyEcVdFRFaXQdt7M+t2/w33HPKIpE2/m62lKFR
        hRlcmYvT0Z+oYrRTbVMwgylrr2Sr7TU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-PLuTen3WNsKLPzh6XGXV_w-1; Mon, 06 Nov 2023 14:31:33 -0500
X-MC-Unique: PLuTen3WNsKLPzh6XGXV_w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778a32da939so494401685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299093; x=1699903893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=t5Kad9NTvJtxk+ZChYKQ7gBH+ryD2gbEv/j5HuC09egtkZuoKG8+ScvDph42w9do7F
         X6x4/O9zl7qOl+FahUkJ1ma0LMjqMeXnJXNI7lx/vVmlNFM4VrrJxkXvomFpLVNQgP8h
         FX7QkftLX9dUiY5rMWwOWItQRl+xn4aY+nFrcqJ61adLW4VmwKdRsx8yfQwE07hjsnBP
         lyH2DNxnvEd6BxphZwxxFzNd92BCT937fOu+960AXKnrV6lwY0rPJKyQeBLqcwsXddrj
         dydKX40fR53msJ1BKb9dRlSA9w/UJQ0qkbGdidaVjZbd3t0TCrd195pQLezgk+Q4uzHA
         5K1g==
X-Gm-Message-State: AOJu0YwIQyLHYbTeWwjYYHYpAA9OwOt5DLjrdMKQgaKzbEvUot5Ttert
        zQY6l0/td002ZqyiumUxkuAS0GbTz1aVksxkQw3cEPYYN6TGmaiIvdiltigEOOlBuswe59h5gVD
        hXwK/1sPb2YGv8Ho7ri1g5I7A
X-Received: by 2002:a05:620a:31a6:b0:773:c4c8:2d58 with SMTP id bi38-20020a05620a31a600b00773c4c82d58mr33054189qkb.59.1699299092997;
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMC4OZw13o7zojxKDTLQnTVqildfL87qAiPF2IC97OBWWvfcH0eCZKZ8LoCuggfuWN7AoEdg==
X-Received: by 2002:a05:620a:31a6:b0:773:c4c8:2d58 with SMTP id bi38-20020a05620a31a600b00773c4c82d58mr33054171qkb.59.1699299092693;
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id oo12-20020a05620a530c00b007758b25ac3bsm3555862qkn.82.2023.11.06.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:31:32 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:31:30 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Julien Gomes <julien@arista.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] tpm: Detach tpm_buf_reset() from tpm_buf_init()
Message-ID: <xp2tdlw2qjg3pbazb3oye7poeh4r5neeqbsvamgiazdl2bouwa@qnxhvt7vzkpb>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-4-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-4-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

