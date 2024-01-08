Return-Path: <linux-kernel+bounces-20008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26182782A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36C3B229EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9355760;
	Mon,  8 Jan 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KKlWThMR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF554FB1;
	Mon,  8 Jan 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id MuztrSdK7BraWMuztrazTF; Mon, 08 Jan 2024 20:09:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704740959;
	bh=mOq/aKB2RTzPjMbrAxOC/iSJc+GWMvTeSluIfsIsb6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KKlWThMRAPRjkJn4Ivdow6dfqTZiVCQ0zlnfp90JaqUuNlVZcWMa7BLViw92ukxMI
	 /S4N+a2Eymwst8/TEZRPC0pd9kZM2JPDLayP6h+TCys51+UBWjGUsQMM+KwJPQdZy9
	 L+0GjFYbDHvs2MmuXHEJx1kGmJAWITSe8qaBGyuF0ul5ktoAJLrxD5Ojb9UFVthW3S
	 ZlEdrEmZvP13fkfnYmsZYLF11moq7bFHRJepQ3m5/oUMemnWmOYRNuOtPNLXunxsx2
	 pQ4Hs5pCSFOphZaeoQLTnT8v2VpZLNeK0Y0kxk+1Wql7O/SyM6S1i9tpUYBmvyOIsr
	 7iMmxvGofr2yQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Jan 2024 20:09:19 +0100
X-ME-IP: 92.140.202.140
Message-ID: <4c6b12c9-0502-400a-b2ba-dad89ef4f652@wanadoo.fr>
Date: Mon, 8 Jan 2024 20:09:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cifs: make cifs_chan_update_iface() a void function
To: Dan Carpenter <dan.carpenter@linaro.org>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg
 <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>,
 Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
 <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/01/2024 à 10:08, Dan Carpenter a écrit :
> The return values for cifs_chan_update_iface() didn't match what the
> documentation said and nothing was checking them anyway.  Just make it
> a void function.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   fs/smb/client/cifsproto.h |  2 +-
>   fs/smb/client/sess.c      | 17 +++++++----------
>   2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index afbab86331a1..a841bf4967fa 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -656,7 +656,7 @@ cifs_chan_is_iface_active(struct cifs_ses *ses,
>   			  struct TCP_Server_Info *server);
>   void
>   cifs_disable_secondary_channels(struct cifs_ses *ses);
> -int
> +void
>   cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
>   int
>   SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_mount);
> diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> index 775c6a4a2f4b..f7b216dd06b2 100644
> --- a/fs/smb/client/sess.c
> +++ b/fs/smb/client/sess.c
> @@ -356,10 +356,9 @@ cifs_disable_secondary_channels(struct cifs_ses *ses)
>   
>   /*
>    * update the iface for the channel if necessary.
> - * will return 0 when iface is updated, 1 if removed, 2 otherwise
>    * Must be called with chan_lock held.
>    */
> -int
> +void
>   cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   {
>   	unsigned int chan_index;
> @@ -368,20 +367,19 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   	struct cifs_server_iface *old_iface = NULL;
>   	struct cifs_server_iface *last_iface = NULL;
>   	struct sockaddr_storage ss;
> -	int rc = 0;
>   
>   	spin_lock(&ses->chan_lock);
>   	chan_index = cifs_ses_get_chan_index(ses, server);
>   	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
>   		spin_unlock(&ses->chan_lock);
> -		return 0;
> +		return;
>   	}
>   
>   	if (ses->chans[chan_index].iface) {
>   		old_iface = ses->chans[chan_index].iface;
>   		if (old_iface->is_active) {
>   			spin_unlock(&ses->chan_lock);
> -			return 1;
> +			return;
>   		}
>   	}
>   	spin_unlock(&ses->chan_lock);
> @@ -394,7 +392,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   	if (!ses->iface_count) {
>   		spin_unlock(&ses->iface_lock);
>   		cifs_dbg(VFS, "server %s does not advertise interfaces\n", ses->server->hostname);
> -		return 0;
> +		return;
>   	}
>   
>   	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
> @@ -434,7 +432,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   	}
>   
>   	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
> -		rc = 1;
>   		iface = NULL;
>   		cifs_dbg(FYI, "unable to find a suitable iface\n");
>   	}
> @@ -449,7 +446,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   		}
>   
>   		spin_unlock(&ses->iface_lock);
> -		return 0;
> +		return;
>   	}
>   
>   	/* now drop the ref to the current iface */
> @@ -478,13 +475,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
>   	chan_index = cifs_ses_get_chan_index(ses, server);
>   	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
>   		spin_unlock(&ses->chan_lock);
> -		return 0;
> +		return;
>   	}
>   
>   	ses->chans[chan_index].iface = iface;
>   	spin_unlock(&ses->chan_lock);
>   
> -	return rc;
> +	return;

just remove this one?

CJ

>   }
>   
>   /*


