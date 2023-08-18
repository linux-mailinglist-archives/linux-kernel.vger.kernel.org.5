Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89458780B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376791AbjHRMKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352896AbjHRMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:09:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C8121;
        Fri, 18 Aug 2023 05:09:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D4F21F74B;
        Fri, 18 Aug 2023 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692360591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bZUqLx6aDKEOVtIoUrNHKk3Ucu59bgR9yuEuVpBRaHM=;
        b=FRQ34vhe/T3rBnmLl5YkJXm5zo1E/juH9fGlDnr+vAMyw3pVkX7jazylobbCzLFWNa4BBD
        O5b34nS54MkVkEYGhVK3tgM6eusS55Dqffvov4d6F84gyqDYsmr51jcS9S+O5KfmPWBIYd
        sSsNAgNWnbv2p0pGPBj0zuTKTUAvZAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692360591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bZUqLx6aDKEOVtIoUrNHKk3Ucu59bgR9yuEuVpBRaHM=;
        b=+90ZxIb/gl/Xzp4wXd+OtPrussY4k1hefjrplLseKn9s/uf1kp6F2hrCnuFba/udCwlgfQ
        WMFT9q7W1fbdkbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F5AF13441;
        Fri, 18 Aug 2023 12:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dzO1A49f32SbegAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 18 Aug 2023 12:09:51 +0000
Date:   Fri, 18 Aug 2023 14:10:02 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v1 1/1] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <2jv5fxbuyd6zqwmgkqydrmgpiozxgebsbq3qzd46uf7xtyo3iv@wmp2ejair6l4>
References: <20230818095744.24619-1-dwagner@suse.de>
 <20230818095744.24619-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818095744.24619-2-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +_nvmet_target_cleanup() {
> +	local ports
> +	local port
> +	local blkdev
> +
> +	_get_nvmet_ports "${def_subsysnqn}" ports
> +
> +	for port in "${ports[@]}"; do
> +		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> +	done
> +	_remove_nvmet_subsystem "${def_subsysnqn}"
> +	_remove_nvmet_port "${port}"

_remove_nvmet_port should be also be part of the loop.

> +	_remove_nvmet_host "${def_hostnqn}"
> +
> +	blkdev="$(losetup -l | awk '$6 == "'"${def_file_path}"'" { print $1 }')"
> +	if [[ -n "${blkdev}" ]] ; then
> +		losetup -d "${blkdev}"
> +	fi
> +	rm "${def_file_path}"
> +}
> +
