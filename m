Return-Path: <linux-kernel+bounces-5102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B42818695
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8BD1C23C48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6217731;
	Tue, 19 Dec 2023 11:47:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359E171CD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AF261F7C5;
	Tue, 19 Dec 2023 11:47:12 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C48B1375D;
	Tue, 19 Dec 2023 11:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l5XxHL+CgWUGOAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:47:11 +0000
Message-ID: <87f65f4d-0a3e-44af-ade8-c9326e5642f9@suse.de>
Date: Tue, 19 Dec 2023 12:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] nvmet-fc: take ref count on tgtport before
 delete assoc
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-17-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-17-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 0AF261F7C5
X-Spam-Flag: NO

On 12/18/23 16:31, Daniel Wagner wrote:
> We have to ensure that the tgtport is not going away
> before be have remove all the associations.

before we have removed all the associations.

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 30ba4ede333f..455d35ef97eb 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1092,13 +1092,28 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   }
>   
>   static void
> -nvmet_fc_delete_assoc(struct work_struct *work)
> +nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
> +{
> +	nvmet_fc_delete_target_assoc(assoc);
> +	nvmet_fc_tgt_a_put(assoc);
> +}
> +
> +static void
> +nvmet_fc_delete_assoc_work(struct work_struct *work)
>   {
>   	struct nvmet_fc_tgt_assoc *assoc =
>   		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
> +	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
>   
> -	nvmet_fc_delete_target_assoc(assoc);
> -	nvmet_fc_tgt_a_put(assoc);
> +	nvmet_fc_delete_assoc(assoc);
> +	nvmet_fc_tgtport_put(tgtport);
> +}
> +
> +static void
> +nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
> +{
> +	nvmet_fc_tgtport_get(assoc->tgtport);
> +	queue_work(nvmet_wq, &assoc->del_work);

Errm.
That is dangerous, as it will leak a reference if 'del_work' is already 
queued.
And we already took a reference from the caller. Why do we need two 
references here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


